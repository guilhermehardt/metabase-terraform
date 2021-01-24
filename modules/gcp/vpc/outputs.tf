output "network_self_link" {
    value = google_compute_network.network.self_link
}

output "subnetwork_subnet_pv_self_link" {
    value = google_compute_subnetwork.subnet-pv-1.self_link
}

output "healthcheck_self_link" {
    value = google_compute_health_check.main.self_link
}

output "gcp_project" {
    value = var.gcp_project_id
}

output "gcp_region" {
    value = var.gcp_region
}