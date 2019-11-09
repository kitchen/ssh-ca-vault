resource "vault_identity_entity" "kitchen" {
  name     = "kitchen"
  policies = ["default"]
}

resource "vault_identity_entity_alias" "userpass-kitchen" {
  name           = vault_identity_entity.kitchen.name
  mount_accessor = vault_auth_backend.userpass.accessor
  canonical_id   = vault_identity_entity.kitchen.id
}

resource "vault_ssh_secret_backend_role" "kitchen" {
  name                    = "kitchen"
  backend                 = vault_mount.ssh.path
  key_type                = "ca"
  allow_user_certificates = true
  allowed_users           = "kitchen"
  default_user            = "kitchen"
  default_extensions = {
    "permit-port-forwarding" : "",
    "permit-pty" : "",
  }
}
