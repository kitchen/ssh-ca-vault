# groups for vault

resource "vault_identity_group" "users" {
  name = "users"
  member_group_ids = [
    vault_identity_group.ssh_users.id,
    vault_identity_group.userpass_users.id
  ]
  member_entity_ids = [
    vault_identity_entity.kitchen.id
  ]
}

resource "vault_identity_group" "ssh_users" {
  name     = "ssh_users"
  policies = [vault_policy.allow_ca.name] # allow signing their own ssh role
}


data "vault_policy_document" "allow_ca" {
  rule {
    description  = "allow users to sign their own keys"
    path         = "sshca/sign/{{ identity.entity.name }}"
    capabilities = ["create", "update"]
  }

  rule {
    description  = "allow users to read the CA public key"
    path         = "sshca/config/ca"
    capabilities = ["read"]
  }
}

resource "vault_policy" "allow_ca" {
  name   = "allow_ca"
  policy = data.vault_policy_document.allow_ca.hcl
}

resource "vault_identity_group" "userpass_users" {
  name     = "userpass_users"
  policies = [vault_policy.allow_changing_password.name] # allow changing their own password
}

data "vault_policy_document" "allow_changing_password" {
  rule {
    description  = "allow users to change their own passwords"
    path         = "auth/userpass/users/{{ identity.entity.aliases.${vault_auth_backend.userpass.accessor}.name }}"
    capabilities = ["update"]
    allowed_parameter {
      key   = "password"
      value = []
    }
  }
}

resource "vault_policy" "allow_changing_password" {
  name   = "allow_changing_password"
  policy = data.vault_policy_document.allow_changing_password.hcl
}
