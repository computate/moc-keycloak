# moc-keycloak

## Testing things locally

1. Spin up a local keycloak instance:

    ```
    make setup
    ```

    It will take a few seconds for keycloak to become healthy.

2. Run `make init-local`. This will:

    - override the S3 backend with a file backend
    - rename `imports.tf` to `imports.tf.disabled`
    - create `local-test.auto.tfvars` to point opentofu at the local keycloak instance

3. Run `tofu plan` or `tofu apply`, etc.

4. When you're done, run `make init-remote`. This will undo the changes introduced by `make init-local`.

5. To tear down your local Keycloak instance:

    ```
    make teardown
    ```

    This will stop the containers, destroy the postgres backing store, and erase your local `terraform.tfstate*` files.

Note that if you are applying this configuration against a fresh keycloak instance, the "CILogon First Broker Login" authentication flow doesn't exist yet, so the realm will fail to apply. You can resolve this by running:

```
tofu apply -var first_broker_login_flow='first broker login'
```

This will allow opentofu to successfully create the realm.

## CI apply via GitHub Actions OIDC

The apply workflow (`.github/workflows/apply.yaml`) applies this
configuration on pushes to `main`. It authenticates to Keycloak using GitHub
Actions' OIDC identity (using [federated client authentication]).

[federated client authentication]: https://www.keycloak.org/2026/01/federated-client-authentication
