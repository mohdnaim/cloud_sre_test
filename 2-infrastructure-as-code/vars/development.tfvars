credentials_path = "airasia-cloud-sre-test-b5798e9c7de1.json"
project_name = "airasia-cloud-sre-test"
region = "us-central1"
zone = "us-central1-a"
bucket_name = "airasia-cloud-sre-test"
remote_state_prefix = "terraform/state/development"

network_name = "airasia-network"
network_auto_create_subnetworks = "true"  #

firewall_name = "airasia-firewall"
firewall_allow_tcp_ports = ["22", "80", "443"]

k8s_cluster_name = "k8s-airasia-dev"
k8s_initial_node_count = 1
k8s_cluster_location = "us-central1"
k8s_cluster_node_locations = ["us-central1-b"] # [] #["us-central1-b","us-central1-c",]
k8s_cluster_ipv4_cidr = "10.0.0.0/14"
k8s_logging_service = "none"
k8s_monitoring_service = "none"

linux_admin_username = "naim"
linux_admin_password = "naimlovesimanghandour"

mysql_master_instance_name = "mysql-master-instance"
mysql_db_version = "MYSQL_5_7"
mysql_db_tier = "db-f1-micro"
mysql_master_instance_availability_type = "REGIONAL"
mysql_replica_pricing_plan = "PER_USE"
mysql_sql_user_name = "airasia_user"
mysql_sql_password = "airasia_google_cloud_sre_test"
mysql_db_name = "airasia-database"

redis_instance_name = "airasia-redis-instance"
redis_tier = "STANDARD_HA"
redis_memory_size_gb = 1
redis_location_id = "us-central1-a"
redis_alternative_location_id = "us-central1-b"
redis_connect_mode = "PRIVATE_SERVICE_ACCESS"
redis_version = "REDIS_3_2"
redis_display_name = "AirAsia Redis Instance"

