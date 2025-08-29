resource "google_compute_address" "rafay_static_ip" {
  name   = "rafay-static-ip"
  region = "us-central1"
}
resource "google_compute_instance" "rafay_base_vm" {
  name         = "rafay-linux-g1-small"
  machine_type = "e2-small"
  zone         = "us-central1-a"

  depends_on = [google_compute_address.rafay_static_ip]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 10
    }
  }

  network_interface {
    network    = "projects/career-growth-43/global/networks/rafay-vpc"
    subnetwork = "projects/career-growth-43/regions/us-central1/subnetworks/rafay-public-subnet-1"

    access_config {
      nat_ip = google_compute_address.rafay_static_ip.address
    }
  }

  tags = ["ssh", "http-server", "https-server"]
  metadata = {
    user-data = <<-EOT
      #!/bin/bash
      echo "Updating package list..."
      apt-get update -y
      echo "Installing Apache..."
      apt-get install -y apache2
      echo "Enabling Apache to start at boot..."
      systemctl enable apache2
      echo "Starting Apache service..."
      systemctl start apache2
      echo "Configuring firewall rules..."
      ufw allow 'Apache Full'
      echo "Checking Apache status..."
      systemctl status apache2
    EOT
ssh-keys ="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCh/yUomkfIhNDyuDnQObmP/0ALlEfMjiqmE8Y54jlHHZuri0g13To5r29G8lig+nOI6DfOmP2Ue5las//4/eAA8+KjS2UegsWp8KZnj/d05NTKq7kOmdtpwcsy0ASLkXYTRawBaB9YVf9au0exd1yDZ5dhooNDvbu/GOQuNawYbYhEqKVfalWE0aP0O3v0nsJDS2fFCXdFOCSNRqGvtuGEfmDro72jNSdnXJLvw4cj0k2B7GAVa8NJm0jDueF6dcWd7M/NokUWub7VkldXW6Gu5T1jObneRp+pbIfLA7II5qDCe+3qPLpz9/JCUBbCTg9ALx4Nf8YKeLfvIdJMaApn rafay" 



  }

}



resource "google_compute_image" "rafay_custom_image" {
  name        = "rafay-custom-image"
  source_disk = google_compute_instance.rafay_base_vm.boot_disk[0].source
  # Optionally, specify additional metadata
  labels = {
    environment = "dev"
  }
}