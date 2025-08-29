resource "google_compute_region_health_check" "rafay_health_check" {
  name               = "rafay-health-check-2"
  region             = var.region
  check_interval_sec = 5
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2

  http_health_check {
    port = 80
    request_path = "/"
  }
}


resource "google_compute_region_backend_service" "rafay_backend_service" {
  name                  = "rafay-regional-backend"
  region                = var.region
  protocol              = "HTTP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  health_checks         = [google_compute_region_health_check.rafay_health_check.id]

  backend {
    group           = var.mig_self_link
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }

    depends_on = [
    google_compute_region_health_check.rafay_health_check
  ]
 }

resource "google_compute_region_url_map" "rafay_url_map" {
  name            = "rafay-url-map"
  region          = var.region
  default_service = google_compute_region_backend_service.rafay_backend_service.id
}

resource "google_compute_region_target_http_proxy" "rafay_http_proxy" {
  name    = "rafay-http-proxy"
  region  = var.region
  url_map = google_compute_region_url_map.rafay_url_map.self_link
}

resource "google_compute_forwarding_rule" "rafay_forwarding_rule" {
  name                  = "rafay-forwarding-rule"
  region                = var.region
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  target                = google_compute_region_target_http_proxy.rafay_http_proxy.self_link
  ip_protocol           = "TCP"
  subnetwork            = var.private_subnet_1
}
