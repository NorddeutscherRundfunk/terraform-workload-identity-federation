variable "project" {}

variable "github_repository" {}

variable "additional_repositories" {
  default = []
}

variable "bucket_name" {}

variable "attribute_condition" {
  description = "attribute_condition to set in google_iam_workload_identity_pool_provider.github. See https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider#attribute_condition"
  type        = string
  default     = "assertion.repository_owner=='NorddeutscherRundfunk'"
}

variable "service_accounts" {
  description = "Bucket service accounts (read-write)"
  type        = set(string)
}
