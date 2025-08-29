resource "google_compute_region_instance_group_manager" "rafay_mig" {
  name                = "rafay-mig"
  base_instance_name  = "rafay-instance"
  region              = var.region
  distribution_policy_zones = ["us-west1-a","us-west1-b"]
  version {
    instance_template = var.rafay_template
  }

  target_size = 2

  auto_healing_policies {
    health_check      = var.health_check
    initial_delay_sec = 60
  }
}   
