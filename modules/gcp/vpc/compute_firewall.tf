resource "google_compute_firewall" "rule-in-lb-health-check" {
  allow {
    protocol = "tcp"
  }

  direction     = "INGRESS"
  disabled      = "false"
  name          = "rule-in-lb-health-check"
  network                  = google_compute_network.network.name
  priority      = "100"
  project       = var.gcp_project_id
  source_ranges = ["209.85.152.0/22", "209.85.204.0/22", "35.191.0.0/16"]
  target_tags   = ["rule-in-lb-health-check"]

  depends_on = [google_compute_network.network]
}

resource "google_compute_firewall" "rule-in-http" {
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  disabled      = "false"
  name          = "rule-in-http"
  network                  = google_compute_network.network.name
  priority      = "110"
  project       = var.gcp_project_id
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["rule-in-http"]

  depends_on = [google_compute_network.network]
}

resource "google_compute_firewall" "rule-in-https" {
  allow {
    ports    = ["443"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  disabled      = "false"
  name          = "rule-in-https"
  network                  = google_compute_network.network.name
  priority      = "120"
  project       = var.gcp_project_id
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["rule-in-https"]

  depends_on = [google_compute_network.network]
}

resource "google_compute_firewall" "rule-in-metabase" {
  allow {
    ports    = ["3000"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  disabled      = "false"
  name          = "rule-in-metabase"
  network                  = google_compute_network.network.name
  priority      = "130"
  project       = var.gcp_project_id
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["rule-in-metabase"]

  depends_on = [google_compute_network.network]
}

resource "google_compute_firewall" "rule-in-ssh" {
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  disabled      = "false"
  name          = "rule-in-ssh"
  network                  = google_compute_network.network.name
  priority      = "140"
  project       = var.gcp_project_id
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["rule-in-ssh"]

  depends_on = [google_compute_network.network]
}
