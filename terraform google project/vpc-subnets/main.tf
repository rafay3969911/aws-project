# VPC Network
resource "google_compute_network" "vpc_network" {
  name                    = "rafay-vpc"
  auto_create_subnetworks = false
}
# Allow HTTP (port 80)
resource "google_compute_firewall" "allow_http" {
  name    = "rafay-allow-http"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  direction = "INGRESS"
  priority  = 1000
  target_tags = ["http-server"]
  source_ranges = ["0.0.0.0/0"]
}

# Allow HTTPS (port 443)
resource "google_compute_firewall" "allow_https" {
  name    = "rafay-allow-https"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  direction = "INGRESS"
  priority  = 1000
  target_tags = ["https-server"]
  source_ranges = ["0.0.0.0/0"]
}

# Allow SSH (port 22)
resource "google_compute_firewall" "allow_ssh" {
  name    = "rafay-allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  direction = "INGRESS"
  priority  = 65534
  target_tags = ["ssh"]
  source_ranges = ["0.0.0.0/0"]
}

# Allow RDP (port 3389)
resource "google_compute_firewall" "allow_rdp" {
  name    = "rafay-allow-rdp"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  direction = "INGRESS"
  priority  = 65534
  target_tags = ["rdp"]
  source_ranges = ["0.0.0.0/0"]
}




# Public Subnet 1
resource "google_compute_subnetwork" "public_subnet_1" {
  name          = "rafay-public-subnet-1"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
  description   = "Public Subnet 1"
}

# Public Subnet 2
resource "google_compute_subnetwork" "public_subnet_2" {
  name          = "rafay-public-subnet-2"
  ip_cidr_range = "10.0.2.0/24"
  region        = "us-east1"
  network       = google_compute_network.vpc_network.id
  description   = "Public Subnet 2"
}

# Private Subnet 1
resource "google_compute_subnetwork" "private_subnet_1" {
  name                     = "rafay-private-subnet-1"
  ip_cidr_range           = "10.0.3.0/24"
  region                  = "us-west1"
  network                 = google_compute_network.vpc_network.id
  private_ip_google_access = true
  description              = "Private Subnet 1"
}

# Private Subnet 2
resource "google_compute_subnetwork" "private_subnet_2" {
  name                     = "rafay-private-subnet-2"
  ip_cidr_range           = "10.0.4.0/24"
  region                  = "us-south1"
  network                 = google_compute_network.vpc_network.id
  private_ip_google_access = true
  description              = "Private Subnet 2"
}

