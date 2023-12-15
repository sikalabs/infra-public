resource "keycloak_openid_client" "sika_io_dex" {
  realm_id                     = keycloak_realm.sika_io.id
  client_id                    = "dex"
  name                         = "dex"
  enabled                      = true
  access_type                  = "CONFIDENTIAL"
  client_secret                = "dex"
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  valid_redirect_uris = [
    "*",
  ]
  valid_post_logout_redirect_uris = [
    "*",
  ]
}

resource "keycloak_openid_client_default_scopes" "sika_io_dex" {
  realm_id  = keycloak_realm.sika_io.id
  client_id = keycloak_openid_client.sika_io_dex.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.sika_io_groups.name,
  ]
}
