provider "google" {
  project = var.gcp_project_id
  region = var.gcp_region
}

provider "google-beta" {
  project = var.gcp_project_id
  region = var.gcp_region
}

terraform {
  required_providers {
    google = {
      version = "~> 3.45.0"
    }
    google-beta = {
      version = "~> 3.49.0"
    }
  }
}
