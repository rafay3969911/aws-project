output "vpc_network" {
  value = google_compute_network.vpc_network.id
}

output "public_subnet_1" {
  value = google_compute_subnetwork.public_subnet_1.id
}

output "public_subnet_2" {
  value = google_compute_subnetwork.public_subnet_2.id
}

output "private_subnet_1" {
  value = google_compute_subnetwork.private_subnet_1.id
}

output "private_subnet_2" {
  value = google_compute_subnetwork.private_subnet_2.id
}


