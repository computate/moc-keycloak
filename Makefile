.PHONY: init-local init-remote all

all:
	@echo "Run one of `make init-local` or `make init-remote`"

define BACKEND_LOCAL
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
endef

define VARS_LOCAL
KEYCLOAK_URL="http://localhost:8080"
KEYCLOAK_USER_NAME="admin"
KEYCLOAK_PASSWORD="admin"
KEYCLOAK_CLIENT_ID="admin-cli"
store_secrets=false
endef

init-local:
	$(file >backend_override.tf,$(BACKEND_LOCAL))
	$(file >local_test.auto.tfvars,$(VARS_LOCAL))
	test -f imports.tf && mv imports.tf imports.tf.disabled || :
	tofu init -reconfigure

init-remote:
	@rm -f backend_override.tf
	@rm -f local_test.auto.tfvars
	test -f imports.tf.disabled && mv imports.tf.disabled imports.tf || :
	echo no | tofu init -reconfigure

setup:
	docker compose up -d

wait:
	@echo "Waiting for keycloak..."; \
		until curl -o /dev/null -sf http://localhost:9000/health; do sleep 1; done; \
		echo "Keycloak is ready."

teardown:
	docker compose down -v
	rm -f terraform.tfstate*
