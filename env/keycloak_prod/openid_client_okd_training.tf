resource "keycloak_openid_client" "okd_training" {
  realm_id              = keycloak_realm.sikalabs.id
  client_id             = "okd-training"
  name                  = "okd-training"
  enabled               = true
  access_type           = "PUBLIC"
  standard_flow_enabled = true
  valid_redirect_uris = [
    "*",
  ]
}

resource "keycloak_openid_audience_protocol_mapper" "okd_training" {
  realm_id                 = keycloak_realm.sikalabs.id
  client_id                = keycloak_openid_client.okd_training.id
  name                     = "audience-mapper"
  included_client_audience = keycloak_openid_client.okd_training.client_id
}

resource "keycloak_openid_client_default_scopes" "okd_training" {
  realm_id  = keycloak_realm.sikalabs.id
  client_id = keycloak_openid_client.okd_training.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.sikalabs_groups.name,
  ]
}
