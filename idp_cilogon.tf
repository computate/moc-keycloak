resource "keycloak_oidc_identity_provider" "cilogon" {
  alias                    = "cilogon"
  authenticate_by_default  = false
  authorization_url        = "https://cilogon.org/authorize"
  backchannel_supported    = false
  client_id                = local.cilogon_credentials.client_id
  client_secret_wo         = local.cilogon_credentials.client_secret
  client_secret_wo_version = 1
  default_scopes           = "openid email profile org.cilogon.userinfo"
  display_name             = "cilogon"
  enabled                  = true
  extra_config = {
    "filteredByClaim"  = "true"
    "claimFilterName"  = "email"
    "claimFilterValue" = "(?i)^[^@\\s]+@(bu\\.edu|redhat\\.com)$"
  }
  first_broker_login_flow_alias = var.first_broker_login_flow
  issuer                        = "https://cilogon.org"
  jwks_url                      = "https://cilogon.org/oauth2/certs"
  login_hint                    = "false"
  logout_url                    = ""
  realm                         = keycloak_realm.moc.id
  store_token                   = false
  sync_mode                     = "IMPORT"
  token_url                     = "https://cilogon.org/oauth2/token"
  trust_email                   = false
  user_info_url                 = "https://cilogon.org/oauth2/userinfo"
}
