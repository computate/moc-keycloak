# ------------------------------------------------------------------------------
# Import blocks for the existing "CILogon First Broker Login" flow in realm moc.
#
# The trailing GUID is the object's ID in Keycloak (sso.massopen.cloud). The
# import ID format is:
#
#   flow:      <realm>/<flow id>
#   subflow:   <realm>/<immediate parent flow alias>/<subflow id>
#   execution: <realm>/<immediate parent flow alias>/<execution id>
#
# The provider takes parent_flow_alias directly from the middle component of the
# import ID (it is never read back from the API), so it MUST equal the
# parent_flow_alias declared for the resource in authentication_flow.tf. A
# mismatch would force replacement of the (production) object.
# ------------------------------------------------------------------------------

import {
  to = keycloak_realm.moc
  id = "moc"
}

import {
  to = keycloak_oidc_identity_provider.cilogon
  id = "moc/cilogon"
}

import {
  for_each = local.openshift_oidc_clusters
  to       = module.openshift_oidc[each.key].keycloak_openid_client.this
  id       = "${local.realm_id}/${each.value.keycloak_client_uuid}"
}

import {
  for_each = local.openshift_oidc_clusters
  to       = module.openshift_oidc[each.key].aws_secretsmanager_secret.this[0]
  id       = each.value.client_secret_name # Or each.value.secret_arn
}

import {
  for_each = local.openshift_oidc_clusters
  to       = module.openshift_oidc[each.key].aws_secretsmanager_secret_version.this[0]
  id       = "${each.value.secret_arn}|${each.value.secret_version_id}"
}

# -- Top-level flow -----------------------------------------------------------

import {
  to = keycloak_authentication_flow.cilogon_first_broker_login
  id = "moc/28975562-fd4b-4b74-a2bf-79bd5ae14a73"
}

# -- Top level (parent: CILogon First Broker Login) ---------------------------

import {
  to = keycloak_authentication_execution.review_profile
  id = "moc/CILogon First Broker Login/4624947c-c5ac-416b-8224-1c093397db6e"
}

import {
  to = keycloak_authentication_subflow.user_creation_or_linking
  id = "moc/CILogon First Broker Login/16e4ee7f-292c-45d7-bc3a-c5513c5d335e"
}

import {
  to = keycloak_authentication_subflow.conditional_organization
  id = "moc/CILogon First Broker Login/b4406b3b-2986-4f2b-bce1-1ac3cccd4a1b"
}

# -- User creation or linking -------------------------------------------------

import {
  to = keycloak_authentication_execution.create_user_if_unique
  id = "moc/CILogon First Broker Login User creation or linking/0857b9b9-02e4-4512-8c3b-d66eb850f111"
}

import {
  to = keycloak_authentication_subflow.handle_existing_account
  id = "moc/CILogon First Broker Login User creation or linking/f5389bed-30fa-4559-95c5-364190471f03"
}

# -- Handle Existing Account --------------------------------------------------

import {
  to = keycloak_authentication_execution.confirm_link
  id = "moc/CILogon First Broker Login Handle Existing Account/a6aa53ea-bb2e-494d-bebf-ca97eb1c65c7"
}

import {
  to = keycloak_authentication_subflow.account_verification_options
  id = "moc/CILogon First Broker Login Handle Existing Account/93ebd082-0b86-4c9f-8d89-69e8a10f7c3f"
}

# -- Account verification options ---------------------------------------------

import {
  to = keycloak_authentication_execution.email_verification
  id = "moc/CILogon First Broker Login Account verification options/2b4e9a70-a1f0-48e9-90f2-90d12fdcd840"
}

import {
  to = keycloak_authentication_subflow.verify_existing_account_by_reauthentication
  id = "moc/CILogon First Broker Login Account verification options/da9d57f9-c125-4d07-a904-7d6814adf077"
}

# -- Verify Existing Account by Re-authentication -----------------------------

import {
  to = keycloak_authentication_execution.username_password_form
  id = "moc/CILogon First Broker Login Verify Existing Account by Re-authentication/e81de971-b987-450e-8bef-52f20664f63f"
}

import {
  to = keycloak_authentication_subflow.conditional_2fa
  id = "moc/CILogon First Broker Login Verify Existing Account by Re-authentication/d0695d6a-ebc3-46df-94cb-9c6d3b22c80b"
}

# -- First broker login - Conditional 2FA -------------------------------------

import {
  to = keycloak_authentication_execution.conditional_2fa_user_configured
  id = "moc/CILogon First Broker Login First broker login - Conditional 2FA/1285f645-a790-4c91-846e-506c65ec809e"
}

import {
  to = keycloak_authentication_execution.conditional_2fa_credential
  id = "moc/CILogon First Broker Login First broker login - Conditional 2FA/b3774177-2b55-447f-a832-f5378801a91a"
}

import {
  to = keycloak_authentication_execution.conditional_2fa_otp
  id = "moc/CILogon First Broker Login First broker login - Conditional 2FA/d267dd60-482c-4504-96ef-c808914fa477"
}

import {
  to = keycloak_authentication_execution.conditional_2fa_webauthn
  id = "moc/CILogon First Broker Login First broker login - Conditional 2FA/3cd6c780-75db-4f77-b550-79ea61b8e5a4"
}

import {
  to = keycloak_authentication_execution.conditional_2fa_recovery_code
  id = "moc/CILogon First Broker Login First broker login - Conditional 2FA/0ae3713a-fa28-4fa0-99cb-682fb7b8f0e8"
}

# -- First Broker Login - Conditional Organization ----------------------------

import {
  to = keycloak_authentication_execution.conditional_org_user_configured
  id = "moc/CILogon First Broker Login First Broker Login - Conditional Organization/6146bb6b-9216-4229-9426-915dc999eb57"
}

import {
  to = keycloak_authentication_execution.add_organization_member
  id = "moc/CILogon First Broker Login First Broker Login - Conditional Organization/a7d84965-fd61-4aff-9be2-c9df35ef32dd"
}

# Groups

import {
  to = keycloak_group.this["coldfront-admins"]
  id = "moc/53ff526d-184a-4397-8005-8c86ce17ee4d"
}

import {
  to = keycloak_group.this["open-accelerator-admins"]
  id = "moc/f12a32d2-f272-41eb-84ad-cca20df6c9b8"
}

import {
  to = keycloak_group.this["pi"]
  id = "moc/12379def-5ca1-43e6-90b1-a95970aa4ab2"
}
