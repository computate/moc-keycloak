
terraform {
  required_version = ">= 1.11.0"

  required_providers {
    keycloak = {
      source  = "registry.terraform.io/keycloak/keycloak"
      version = "~> 5.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
