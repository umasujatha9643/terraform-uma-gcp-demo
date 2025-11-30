variable "project_id" {
  description = "GCP Project id"
  type = string
}


variable "region" {
  description = "GCP region"
    type = string
    default = "us-central1"

}

variable "zone" {
  description = "GCP zone"
  type = string
  default = "us-central1-a"
}