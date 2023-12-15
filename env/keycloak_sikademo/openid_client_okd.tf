resource "keycloak_openid_client" "okd" {
  realm_id                     = keycloak_realm.sikademo.id
  client_id                    = "okd"
  name                         = "okd"
  enabled                      = true
  access_type                  = "CONFIDENTIAL"
  client_secret                = "okd"
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  valid_redirect_uris = [
    "*",
  ]
  valid_post_logout_redirect_uris = [
    "*",
  ]
}

resource "keycloak_openid_client_default_scopes" "okd" {
  realm_id  = keycloak_realm.sikademo.id
  client_id = keycloak_openid_client.okd.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.sikademo_groups.name,
  ]
}
