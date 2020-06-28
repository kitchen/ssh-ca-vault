# TODO: extract this out as a module somehow?
# my only concern really is that groups seem to need the complete list of members
# so how do I do that while creating users with modules? :shrug:

# alternatively, if vault's ACL stuff allowed for templating in the parameters
# bits, we could make it so there's a single ssh ca role that allows all
# usernames (read: principals) to be specified, but the ACL limits it to the
# identity's name. Maybe. That's kinda what I was hoping for, anyways :)

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
    "permit-agent-farwording" : "",
  }
}
