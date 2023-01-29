variable "keycloak_openid_client_grafana_client_secret" {}

resource "keycloak_openid_client" "grafana" {
  realm_id              = keycloak_realm.sikalabs.id
  client_id             = "grafana"
  name                  = "grafana"
  enabled               = true
  access_type           = "CONFIDENTIAL"
  client_secret         = var.keycloak_openid_client_grafana_client_secret
  standard_flow_enabled = true
  valid_redirect_uris = [
    "*",
  ]
}

resource "keycloak_openid_client_default_scopes" "grafana" {
  realm_id  = keycloak_realm.sikalabs.id
  client_id = keycloak_openid_client.grafana.id
  default_scopes = [
    "openid",
    "profile",
    "email",
    keycloak_openid_client_scope.sikalabs_groups.name,
  ]
}
