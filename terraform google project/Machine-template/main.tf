resource "google_compute_instance_template" "rafay_template" {
  name           = "rafay-template"
  machine_type   = "e2-small"
  region = var.region

 # ✅ Use your custom image here
  disk {
    source_image = var.rafay_custom_image
    auto_delete  = true
    boot         = true

    # ✅ Specify balanced persistent disk
    disk_type = "pd-balanced"
  }

  network_interface {
    # ✅ Use private subnet here (NO external IP)
    subnetwork = var.private_subnet_1  # <-- PRIVATE subnet lagani he

    # ❌ REMOVE this block for private-only VM (no public IP)
    # access_config {}
  }

  labels = {
    env = "private"
  }

  tags = ["rafay-prt-1", "rafay-prt-2"]
}