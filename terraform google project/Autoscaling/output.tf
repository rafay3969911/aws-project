output "rafay_mig" {
  value = google_compute_region_instance_group_manager.rafay_mig.id
}

output "mig_self_link" {
  value = google_compute_region_instance_group_manager.rafay_mig.instance_group
}
