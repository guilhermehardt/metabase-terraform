resource "google_compute_subnetwork" "subnet-pb-1" {
  ip_cidr_range            = "10.10.0.0/20"
  name                     = "subnet-${var.env_name}-pb-1"
  network                  = google_compute_network.network.name
  private_ip_google_access = "true"
  project                  = var.gcp_project_id
  region                   = var.gcp_region

  depends_on = [google_compute_network.network]
}

resource "google_compute_subnetwork" "subnet-pv-1" {
  ip_cidr_range            = "10.10.16.0/20"
  name                     = "subnet-${var.env_name}-pv-1"
  network                  = google_compute_network.network.name
  private_ip_google_access = "true"
  project                  = var.gcp_project_id
  region                   = var.gcp_region

  depends_on = [google_compute_network.network]
}
