listener "tcp" {
  tls_disable = true
  address = "0.0.0.0:8200"
}

seal "gcpckms" {
  project = "ssh-ca-vault"
  region = "us-central1"
  key_ring = "vault"
  crypto_key = "vault_seal"
}

storage "gcs" {
  bucket = "ssh-ca-vault"
}

ui = true
