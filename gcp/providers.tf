provider "google" {
  project = var.gcp_project
  region  = "us-central1"
}

resource "google_project_service" "ssh-ca-vault-kms" {
  service = "cloudkms.googleapis.com"
}
