resource "google_compute_health_check" "main" {
  check_interval_sec = "10"
  healthy_threshold  = "2"
  name               = "healthcheck-${var.env_name}"

  tcp_health_check {
    port         = "3000"
    proxy_header = "NONE"
  }

  timeout_sec         = "5"
  unhealthy_threshold = "3"
}
