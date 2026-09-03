locals {
  keycloak_groups = toset([
    "open-accelerator-admins",
    "coldfront-admins",
    "pi"
  ])
}

resource "keycloak_group" "this" {
  for_each = local.keycloak_groups

  realm_id = keycloak_realm.moc.id
  name     = each.value
}
