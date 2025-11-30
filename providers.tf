terraform {
  required_version = ">= 1.3.0"

  backend "gcs" {
    bucket = "gce-day1-uma-tf-state"
    prefix = "envs/dev"
  }
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "~> 5.0"
    }
  }
}

provider "google" {

    project = "var.project_id"
    region  = "var.region"
  
}