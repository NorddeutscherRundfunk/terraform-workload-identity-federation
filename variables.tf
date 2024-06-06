variable "project" {
  description = "GCP project ID"
  type        = string
}

variable "github_repository" {
  description = "GitHub repository name"
  type        = string
}

variable "additional_repositories" {
  description = "List of additional GitHub repository names"
  type        = list(string)
  default     = []
}

variable "bucket_name" {
  description = "GCP bucket name"
  type        = string
}
