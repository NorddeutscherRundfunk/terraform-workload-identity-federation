terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      # https://registry.terraform.io/providers/hashicorp/google/latest
      source  = "hashicorp/google"
      version = "5.32.0"
    }
  }
}
