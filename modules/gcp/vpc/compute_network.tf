resource "google_compute_network" "network" {
  auto_create_subnetworks         = "false"
  name                            = "vpc-${var.env_name}"
  routing_mode                    = "REGIONAL"
}