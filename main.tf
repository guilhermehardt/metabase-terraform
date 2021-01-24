
# GCP Environment Variables
variable "gcp_project_id" {
    default = "deft-stratum-XXXXX"
}
variable "gcp_region" {
    default = "us-east4"
}
variable "gcp_zone" {
  default = "us-east4-c"
}
variable "env_name" {
    default = "metabase1"
}

# VPC Module
module "vpc" {
  source = "./modules/gcp/vpc"
  gcp_project_id = var.gcp_project_id
  gcp_region = var.gcp_region
  env_name = var.env_name
}

# Metabase Instance 1
module "metabase_1" {
  source = "./modules/gcp/metabase"
  gcp_project_id = var.gcp_project_id
  gcp_region = var.gcp_region
  env_name = var.env_name
  vm_zone = var.gcp_zone

  # custom args
  network = module.vpc.network_self_link
  subnetwork = module.vpc.subnetwork_subnet_pv_self_link
  healthcheck_self_link = module.vpc.healthcheck_self_link
  domain_name = "my.domain.net"
  vm_type  = "e2-medium"
  db_type = "db-f1-micro"
  db_version = "POSTGRES_12"
  db_username = "admin"
  db_password = "admin"
  db_databasename = "my_db"
  private_key_path = "./gcp_instance"
}