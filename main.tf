resource "google_compute_network" "demo_vpc" {
    name = "demo-vpc"
    auto_create_subnetworks = true
  
}

resource "google_compute_instance" "demo_instance" {
    name         = "demo-instance"
    machine_type = "e2-medium"
    zone         = "us-central1-a"
  
    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-11"
      }
    }
  
    network_interface {
      network = google_compute_network.demo_vpc.name
      access_config {}
    }
  
    tags = ["http-server"]
}