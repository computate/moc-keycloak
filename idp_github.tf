# Trust GitHub Actions' OIDC issuer for *client* authentication (federated
# client authentication). This lets a GitHub Actions workflow authenticate to
# Keycloak by presenting a GitHub-signed JWT as a client assertion, instead of a
# client secret. Enabled by `supportsClientAssertions`; Keycloak verifies token
# signatures against GitHub's published JWKS.
resource "keycloak_oidc_identity_provider" "github_actions" {
  realm = "master"
  alias = "github-actions"

  issuer             = var.github_actions_issuer
  validate_signature = true
  jwks_url           = var.github_actions_jwks_url

  # Required by the resource schema but unused for the client-assertion flow
  # (GitHub Actions is not an interactive login IdP for this realm).
  authorization_url = var.github_actions_issuer
  token_url         = var.github_actions_issuer
  client_id         = "unused"
  client_secret     = "unused"

  # Do not offer this IdP as a login option in the UI.
  enabled            = true
  hide_on_login_page = true

  extra_config = {
    supportsClientAssertions = "true"
  }
}
