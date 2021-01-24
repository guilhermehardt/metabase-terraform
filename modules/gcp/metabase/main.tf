resource "google_compute_instance" "main" {
  count        = 1
  name         = "${var.env_name}-${count.index + 1}"
  machine_type = var.vm_type
  zone         = var.vm_zone

  boot_disk {
    initialize_params {
      image = var.vm_image
    }
  }

  tags                 = [
      "rule-in-https",
      "rule-in-http",
      "rule-in-metabase",
      "rule-in-ssh",
  ]

  network_interface {
    network = var.network
    subnetwork = var.subnetwork
    
    access_config {
        nat_ip = ""
    }
  }

  metadata_startup_script = file("./init.sh")

  metadata = {
    ssh-keys = "ubuntu:${file("./gcp_instance.pub")}"
  }
  connection {
    user        = "ubuntu"
    host = google_compute_instance.main.0.network_interface.0.access_config.0.nat_ip
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    source = "./docker-compose.yaml"
    destination = "/tmp/docker-compose.yaml"
  }

  # depends_on = [ google_sql_database_instance.main ]
}

resource "null_resource" "metabase-main" {
  depends_on = [ google_compute_instance.main ] 
  connection {
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = google_compute_instance.main.0.network_interface.0.access_config.0.nat_ip
  }
  provisioner "remote-exec" {
    inline = [
        "sudo docker-compose -f /tmp/docker-compose.yml pull",
        "sudo docker-compose -f /tmp/docker-compose.yml bundle -o metabase.dab",
        "sudo docker deploy metabase"
    ]
  }
}

# instance group
resource "google_compute_instance_group" "main" {
  count        = 1
  name        = "${var.env_name}-${count.index + 1}"

  instances = [
    google_compute_instance.main[0].id
  ]

  named_port {
    name = "http"
    port = "3000"
  }

  zone = var.vm_zone
}

# lb backend
resource "google_compute_backend_service" "main" {
  affinity_cookie_ttl_sec = "0"

  backend {
    balancing_mode               = "UTILIZATION"
    capacity_scaler              = "1"
    group                        = google_compute_instance_group.main[0].self_link
    max_connections              = "0"
    max_connections_per_endpoint = "0"
    max_connections_per_instance = "0"
    max_rate                     = "0"
    max_rate_per_endpoint        = "0"
    max_rate_per_instance        = "0"
    max_utilization              = "1"
  }

  connection_draining_timeout_sec = "300"
  enable_cdn                      = "false"
  health_checks                   = [var.healthcheck_self_link]
  load_balancing_scheme           = "EXTERNAL"

  log_config {
    enable      = "true"
    sample_rate = "1"
  }

  name             = var.env_name
  port_name        = "http"
  protocol         = "HTTP"
  session_affinity = "NONE"
  timeout_sec      = "30"
}

resource "google_compute_url_map" "main" {
  default_service = google_compute_backend_service.main.self_link

  host_rule {
    hosts        = [var.domain_name]
    path_matcher = "path-matcher-1"
  }

  name = "lb-https-${var.env_name}"

  path_matcher {
    default_service = google_compute_backend_service.main.self_link
    name            = "path-matcher-1"
  }
}

resource "google_compute_url_map" "main-http" {
  default_url_redirect {
    https_redirect         = "true"
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = "false"
  }

  name = "lb-http-${var.env_name}"
}

# # Database Instance
# resource "google_sql_database_instance" "main" {
#   name             = var.env_name
#   database_version = var.db_version

#   settings {
#     tier = var.db_type

#     backup_configuration {
#       enabled = true
#       start_time = "01:00"
#     }

#     ip_configuration {
#       # Authorized instance
#       dynamic "authorized_networks" {
#         for_each = google_compute_instance.main
#         iterator = main

#         content {
#           name  = main.value.name
#           value = main.value.network_interface.0.access_config.0.nat_ip
#         }
#       }
#     }
#   }
# }
# # Database User
# resource "google_sql_user" "main" {
#   name     = var.db_username
#   instance = google_sql_database_instance.main.name
#   password = var.db_password
# }
# # Database
# resource "google_sql_database" "main" {
#   name     = var.db_databasename
#   instance = google_sql_database_instance.main.name
# }
