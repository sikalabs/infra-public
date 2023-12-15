resource "keycloak_openid_client" "sikademo_awx" {
  realm_id                     = keycloak_realm.sikademo.id
  client_id                    = "awx"
  name                         = "awx"
  enabled                      = true
  access_type                  = "CONFIDENTIAL"
  client_secret                = "awx"
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  valid_redirect_uris = [
    "*",
  ]
  valid_post_logout_redirect_uris = [
    "*",
  ]
}

resource "keycloak_openid_client_default_scopes" "sikademo_awx" {
  realm_id  = keycloak_realm.sikademo.id
  client_id = keycloak_openid_client.sikademo_awx.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.sikademo_groups.name,
  ]
}
