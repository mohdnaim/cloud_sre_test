# use Google Cloud Platform GCP
provider "google" {
  credentials = file(var.credentials_path)  # credentials = "${file("airasia-cloud-sre-test-b5798e9c7de1.json")}"
  project = var.project_name
  region = var.region
  zone = var.zone
}


# Another GCP provider for some new API libraries / services
provider "google-beta" { 
  credentials = file(var.credentials_path)
  project = var.project_name
  region = var.region
  zone = var.zone
}


# Define remote state
data "terraform_remote_state" "terraform_remote_state" {
  backend = "gcs"

  config = {
    credentials = file(var.credentials_path)
    bucket = var.bucket_name
    prefix = var.remote_state_prefix
  }
}

terraform {
  backend "gcs" { # hashicorp doesn't allow using variables in this block so: terraform init --backend-config=backend_config.hcl
  }
}


# Create a Network
resource "google_compute_network" "network" {
  name = var.network_name
  auto_create_subnetworks = var.network_auto_create_subnetworks
}


# Create a Firewall in google_compute_network
resource "google_compute_firewall" "firewall" {
  name = var.firewall_name

  network = google_compute_network.network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = var.firewall_allow_tcp_ports
  }
}


# Create a Kubernetes cluster
resource "google_container_cluster" "cluster" {
  name = var.k8s_cluster_name
  network = var.network_name
  location = var.k8s_cluster_location
  initial_node_count = var.k8s_initial_node_count

  node_locations = var.k8s_cluster_node_locations

  # master_auth {
  #   username = var.linux_admin_username
  #   password = var.linux_admin_password
  # }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  addons_config {
    http_load_balancing {
      disabled = false  # HorizontalPodAutoscaler
    }
    
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = false
    master_ipv4_cidr_block = "192.168.128.0/28"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "0.0.0.0/0"
      display_name = "cidr-block"
    }
  }

  ip_allocation_policy {  # adding this block enables IP aliasing, making the cluster VPC-native instead of routes-based
  }

  # cluster_ipv4_cidr = var.k8s_cluster_ipv4_cidr

  logging_service = "none"

  monitoring_service = "none"
}


# Random ID
resource "random_id" "db_name_suffix" {
  byte_length = 4
}


# Create Private IP Address
resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name = "private-ip-address"
  purpose = "VPC_PEERING"
  address_type = "INTERNAL"
  prefix_length = 16
  network = google_compute_network.network.id
  depends_on = [var.network_name]
}


# Create Networking Connection - for private VPC connection
resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network = google_compute_network.network.id
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
  depends_on = [var.network_name]
}


# Create MySQL - Master instance
resource "google_sql_database_instance" "database_master_instance" {
  provider = google-beta

  name = var.mysql_master_instance_name
  database_version = var.mysql_db_version
  region = var.region

  depends_on = [google_service_networking_connection.private_vpc_connection]

	settings {
		tier = var.mysql_db_tier

    availability_type = var.mysql_master_instance_availability_type  # REGIONAL = high availability, ZONAL=single zone

		backup_configuration {
			enabled = true
			binary_log_enabled = true
		}

    ip_configuration {
      ipv4_enabled = false  # don't assign public IPV4 address
      private_network = google_compute_network.network.id
    }
	}
}


# Create MySQL - Replica instances
resource "google_sql_database_instance" "database_replica_instances" {
  provider = google-beta

  name = "mysql-replica-${random_id.db_name_suffix.hex}"
  master_instance_name = google_sql_database_instance.database_master_instance.name  # mandatory for replica_configuration block

  database_version = var.mysql_db_version
  region = var.region

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = var.mysql_db_tier

    disk_autoresize = true

    pricing_plan = var.mysql_replica_pricing_plan

    ip_configuration {
      ipv4_enabled = false  # don't assign public IPV4 address
      private_network = google_compute_network.network.id
    }
  }
}


# Create a Google SQL user on SQL User Instance
resource "google_sql_user" "users" {
  name = var.mysql_sql_user_name
  instance = google_sql_database_instance.database_master_instance.name
  password = var.mysql_sql_password
}


# Create a MySQL database in the MySQL database instances
resource "google_sql_database" "database" {
  name     = var.mysql_db_name
  instance = google_sql_database_instance.database_master_instance.name
}


# Create Redis instance - High availability
resource "google_redis_instance" "redis_instance" {
  name = var.redis_instance_name
  tier = var.redis_tier
  memory_size_gb = var.redis_memory_size_gb

  location_id = var.redis_location_id
  alternative_location_id = var.redis_alternative_location_id

  authorized_network = google_compute_network.network.id

  connect_mode = var.redis_connect_mode
  depends_on = [google_service_networking_connection.private_vpc_connection]

  redis_version = var.redis_version
  display_name = var.redis_display_name
}
