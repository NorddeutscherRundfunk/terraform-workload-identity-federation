resource "google_service_account" "tf-github" {
  project    = var.project
  account_id = "tf-github"
}

resource "google_iam_workload_identity_pool" "github" {
  provider                  = google-beta
  project                   = var.project
  display_name              = "GitHub pool"
  workload_identity_pool_id = "github"
}

resource "google_iam_workload_identity_pool_provider" "github" {
  provider                           = google-beta
  project                            = var.project
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = "github"
  display_name                       = "GitHub provider"
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.aud"        = "assertion.aud"
    "attribute.repository" = "assertion.repository"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account_iam_binding" "workload" {
  service_account_id = google_service_account.tf-github.id
  members            = formatlist("principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository/%s", concat(var.additional_repositories, [var.github_repository]))
  role               = "roles/iam.workloadIdentityUser"
}

resource "google_project_iam_member" "tf-github" {
  project = var.project
  member  = "serviceAccount:${google_service_account.tf-github.email}"
  role    = "roles/owner"
}

resource "google_storage_bucket_iam_member" "tf-github" {
  bucket = var.bucket_name
  member = "serviceAccount:${google_service_account.tf-github.email}"
  role   = "roles/storage.admin"
}
