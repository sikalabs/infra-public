resource "keycloak_openid_client" "tailscale" {
  realm_id                     = keycloak_realm.sikalabs.id
  client_id                    = "tailscale"
  name                         = "tailscale"
  enabled                      = true
  access_type                  = "CONFIDENTIAL"
  client_secret                = "tailscale"
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  valid_redirect_uris = [
    "*",
  ]
}

resource "keycloak_openid_client_default_scopes" "tailscale" {
  realm_id  = keycloak_realm.sikalabs.id
  client_id = keycloak_openid_client.tailscale.id
  default_scopes = [
    "profile",
    "email",
    "groups",
  ]
}
