data "keycloak_authentication_execution" "idp_redirector" {
  realm_id          = keycloak_realm.moc.id
  parent_flow_alias = "browser"
  provider_id       = "identity-provider-redirector"
}

resource "keycloak_authentication_execution_config" "idp_redirector" {
  realm_id     = keycloak_realm.moc.id
  execution_id = data.keycloak_authentication_execution.idp_redirector.id

  alias = "default-identity-provider"

  config = {
    defaultProvider = keycloak_oidc_identity_provider.cilogon.id
  }
}
