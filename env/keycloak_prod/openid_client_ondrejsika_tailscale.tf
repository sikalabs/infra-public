resource "keycloak_openid_client" "ondrejsika_tailscale" {
  realm_id                     = keycloak_realm.ondrejsika.id
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

resource "keycloak_openid_client_default_scopes" "ondrejsika_tailscale" {
  realm_id  = keycloak_realm.ondrejsika.id
  client_id = keycloak_openid_client.ondrejsika_tailscale.id
  default_scopes = [
    "profile",
    "email",
    "groups",

  ]
}
