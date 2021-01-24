# Common Variables
variable "env_name" {
    description = "Environment Name"
}

variable "domain_name" {
    description = "Domain name"
}

variable "vm_type" {
    description = "Instance Type (default: e2-medium)"
    default = "e2-medium"
}

variable "private_key_path" {
  description = "Private Key Path"
}

variable "vm_zone" {
    description = "VPC Zone"
}

variable "vm_image" {
    description = "Instance Image Name"
    default = "debian-10-buster-v20200714"
}

# Self link from VPC outputs
variable "network" {
    description = "Network self link (output VPC)"
}

variable "subnetwork" {
    description = "Subnet self link (output VPC)"
}

variable "healthcheck_self_link" {
    description = "Healthcheck self link (output VPC)"
}

# Database Variables
variable "db_type" {
    description = "SQL Instance Type (default: db-f1-micro)"
    default = "db-f1-micro"
}

variable "db_version" {
    description = "Database (defaul: POSTGRES_12)"
    default = "POSTGRES_12"
}

variable "db_username" {
    description = "Database username"
    default = "admin"
}

variable "db_password" {
    description = "Database password"
    default = "admin"
}

variable "db_databasename" {
    description = "Database Name"
    default = "my_db"
}

variable "gcp_project_id" {
    description = "GCP Project Id"
}

variable "gcp_region" {
    description = "GCP Region"
    default = "us-east1"
}