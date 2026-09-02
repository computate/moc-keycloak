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
  default     = "repo:CCI-MOC/moc-keycloak:ref:refs/heads/main"
}
