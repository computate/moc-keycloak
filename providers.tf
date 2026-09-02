
variable "KEYCLOAK_URL" {
  type    = string
  default = "https://sso.massopen.cloud"
}

variable "KEYCLOAK_CLIENT_ID" {
  type    = string
  default = null
}

variable "KEYCLOAK_USER_NAME" {
  type    = string
  default = null
}

variable "KEYCLOAK_PASSWORD" {
  type      = string
  sensitive = true
  default   = null
}

variable "KEYCLOAK_JWT_TOKEN_FILE" {
  type        = string
  default     = null
  description = "Path to a file containing a signed JWT used for federated client authentication (used by CI instead of username/password)."
}

provider "keycloak" {
  url            = var.KEYCLOAK_URL
  client_id      = var.KEYCLOAK_CLIENT_ID
  username       = var.KEYCLOAK_USER_NAME
  password       = var.KEYCLOAK_PASSWORD
  jwt_token_file = var.KEYCLOAK_JWT_TOKEN_FILE
}

provider "aws" {
  region = "us-east-1"
}
