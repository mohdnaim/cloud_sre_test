# Input variables

variable "credentials_path" {
    type = string
}

variable "project_name" {
    type = string
}

variable "region" {
    type = string
}

variable "zone" {
    type = string
}

variable "bucket_name" {
    type = string
}

variable "remote_state_prefix" {
    type = string
}

variable "network_name" {
    type = string
}

variable "network_auto_create_subnetworks" {
    type = string
}

variable "firewall_name" {
    type = string
}

variable "firewall_allow_tcp_ports" {
    type = list(string)
}

variable "k8s_cluster_name" {
  type = string
}

variable "k8s_initial_node_count" {
  type = number
}

variable "k8s_cluster_location" {
  type = string
}

variable "k8s_cluster_node_locations" {
  type = list(string)
}

variable "k8s_cluster_ipv4_cidr" {
  type = string
}

variable "k8s_logging_service" {
  type = string
}

variable "k8s_monitoring_service" {
  type = string
}

variable "linux_admin_username" {
  type = string
}

variable "linux_admin_password" {
  type = string
}

variable "mysql_master_instance_name" {
  type = string
}

variable "mysql_db_version" {
  type = string
}

variable "mysql_db_tier" {
  type = string
}

variable "mysql_master_instance_availability_type" {
  type = string
}

variable "mysql_replica_pricing_plan" {
  type = string
}

variable "mysql_sql_user_name" {
  type = string
}

variable "mysql_sql_password" {
  type = string
}

variable "mysql_db_name" {
  type = string
}

variable "redis_instance_name" {
  type = string
}

variable "redis_tier" {
  type = string
}

variable "redis_memory_size_gb" {
  type = number
}

variable "redis_location_id" {
  type = string
}

variable "redis_alternative_location_id" {
  type = string
}

variable "redis_connect_mode" {
  type = string
}

variable "redis_version" {
  type = string
}

variable "redis_display_name" {
  type = string
}

# Output variables

output "k8s_cluster_endpoint" {
  value = "${google_container_cluster.cluster.endpoint}"
}

output "k8s_ssh_command" {
  value = "ssh ${var.linux_admin_username}@${google_container_cluster.cluster.endpoint}"
}

output "k8s_cluster_name" {
  value = "${google_container_cluster.cluster.name}"
}

output "k8s_cluster_services_ipv4_cidr" {
  value = "${google_container_cluster.cluster.services_ipv4_cidr}"
}

output "mysql_master_instance_first_ip_address" {
  value = "${google_sql_database_instance.database_master_instance.first_ip_address}"
}

output "mysql_master_instance_private_ip_address" {
  value = "${google_sql_database_instance.database_master_instance.private_ip_address}"
}

output "redis_host" {
  value = "${google_redis_instance.redis_instance.host}"
}

output "redis_port" {
  value = "${google_redis_instance.redis_instance.port}"
}
