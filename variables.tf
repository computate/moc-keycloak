variable "first_broker_login_flow" {
  type        = string
  description = "Name of first broker login authentication flow"
  default     = "CILogon First Broker Login"
}

variable "store_secrets" {
  type        = bool
  default     = true
  description = "Store secrets to AWS secrets manager when true"
}

variable "github_actions_issuer" {
  type        = string
  description = "OIDC issuer for GitHub Actions tokens."
  default     = "https://token.actions.githubusercontent.com"
}

variable "github_actions_jwks_url" {
  type        = string
  description = "JWKS URL used to verify GitHub Actions OIDC token signatures."
  default     = "https://token.actions.githubusercontent.com/.well-known/jwks"
}

variable "github_actions_subject" {
  type        = string
  description = "GitHub Actions OIDC `sub` claim allowed to authenticate as the federated client."
  # This repo's OIDC subject uses GitHub's immutable org/repo IDs, so the plain
  # "repo:CCI-MOC/moc-keycloak:..." form is never what the token carries and
  # would never match. Value obtained with:
  #   gh api repos/CCI-MOC/moc-keycloak/actions/oidc/customization/sub --jq .sub_claim_prefix
  default = "repo:CCI-MOC@3578683/moc-keycloak@1352835750:ref:refs/heads/main"
}
