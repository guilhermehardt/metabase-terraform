output "backend_service_self_link" {
    value = google_compute_backend_service.main.self_link
}

output "domain_name" {
    value = var.domain_name
}