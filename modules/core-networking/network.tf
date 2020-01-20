resource "google_compute_network" "mgmt_vpc" {
  name                    = "mgmt-vpc"
  auto_create_subnetworks = "false"
  routing_mode = "REGIONAL"
}
resource "google_compute_subnetwork" "mgmt_subnet" {
  name          = "mgmt-subnet"
  ip_cidr_range = var.mgmt_cidr
  region        = var.region
  network       = google_compute_network.mgmt_vpc.self_link

}
resource "google_compute_network" "internal_vpc" {
  name                    = "internal-vpc"
  auto_create_subnetworks = "false"
  routing_mode = "REGIONAL"
}
resource "google_compute_subnetwork" "internal_subnet" {
  name          = "internal-subnet"
  ip_cidr_range = var.internal_cidr
  region        = var.region
  network       = google_compute_network.internal_vpc.self_link

}
resource "google_compute_network" "external_vpc" {
  name                    = "external-vpc"
  auto_create_subnetworks = "false"
  routing_mode = "REGIONAL"
}
resource "google_compute_subnetwork" "external_subnet" {
  name          = "external-subnet"
  ip_cidr_range = var.external_cidr
  region        = var.region
  network       = google_compute_network.external_vpc.self_link

}
resource "google_compute_firewall" "default_allow_internal_mgmt" {
  name    = "default-allow-internal-mgmt"
  network = google_compute_network.mgmt_vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  priority = "65534"

  source_ranges = ["${var.internal_cidr}"]
}
resource "google_compute_firewall" "default_allow_internal_external" {
  name    = "default-allow-internal-external"
  network = google_compute_network.external_vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  priority = "65534"

  source_ranges = [var.external_cidr]
}
resource "google_compute_firewall" "default_allow_internal_internal" {
  name    = "default-allow-internal-internal"
  network = google_compute_network.internal_vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  priority = "65534"

  source_ranges = [var.internal_cidr]
}
