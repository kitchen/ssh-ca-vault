resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_mount" "ssh" {
  type                      = "ssh"
  path                      = "sshca"
  description               = "kitchen's awesome ssh certificate authority"
  default_lease_ttl_seconds = 604800  # 1 week
  max_lease_ttl_seconds     = 2592000 # 30 days
}

resource "vault_ssh_secret_backend_ca" "sshca" {
  backend              = vault_mount.ssh.path
  generate_signing_key = true
}
