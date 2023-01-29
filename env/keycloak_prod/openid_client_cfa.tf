variable "keycloak_openid_client_cfa_client_secret" {}

resource "keycloak_openid_client" "cfa" {
  realm_id              = keycloak_realm.sikalabs.id
  client_id             = "cfa"
  name                  = "cfa"
  enabled               = true
  access_type           = "CONFIDENTIAL"
  client_secret         = var.keycloak_openid_client_cfa_client_secret
  standard_flow_enabled = true
  valid_redirect_uris = [
    "*",
  ]
}
