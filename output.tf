output "vm_external_ip" {
    description = "External IP of demo VM"
    value = google_compute_instance.demo_instance.network_interface[0].access_config[0].nat_ip
  
}