# A confidential client that authenticates using a JWT issued by GitHub Actions
# (federated client authentication) rather than a client secret. Keycloak
# resolves this client from the assertion's `sub` claim, matched against
# `jwt.credential.sub`, and verifies it against the `github-actions` identity
# provider named in `jwt.credential.issuer`.
resource "keycloak_openid_client" "github_actions" {
  realm_id  = "master"
  client_id = "github-actions"
  name      = "GitHub Actions (federated)"
  enabled   = true

  access_type                  = "CONFIDENTIAL"
  client_authenticator_type    = "federated-jwt"
  service_accounts_enabled     = true
  standard_flow_enabled        = false
  implicit_flow_enabled        = false
  direct_access_grants_enabled = false

  # extra_config is for setting values that aren't directly supported by the
  # opentofu keycloak provider. Support for federated authentication was
  # introduced relatively recently and the feature has not yet been added to
  # the provider.
  extra_config = {
    "jwt.credential.issuer" = keycloak_oidc_identity_provider.github_actions.alias
    "jwt.credential.sub"    = var.github_actions_subject
  }
}

# The master realm's built-in `admin` role grants full administrative access,
# matching the access level of the admin-cli credentials used today.
data "keycloak_role" "master_admin" {
  realm_id = "master"
  name     = "admin"
}

resource "keycloak_openid_client_service_account_realm_role" "github_actions_admin" {
  realm_id                = "master"
  service_account_user_id = keycloak_openid_client.github_actions.service_account_user_id
  role                    = data.keycloak_role.master_admin.name
}
