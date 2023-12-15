resource "keycloak_openid_client" "minio" {
  realm_id              = keycloak_realm.sikalabs.id
  client_id             = "minio"
  name                  = "minio"
  enabled               = true
  access_type           = "PUBLIC"
  standard_flow_enabled = true
  valid_redirect_uris = [
    "*",
  ]
}

resource "keycloak_openid_audience_protocol_mapper" "minio" {
  realm_id                 = keycloak_realm.sikalabs.id
  client_id                = keycloak_openid_client.minio.id
  name                     = "audience-mapper"
  included_client_audience = keycloak_openid_client.minio.client_id
}

resource "keycloak_openid_client_default_scopes" "minio" {
  realm_id  = keycloak_realm.sikalabs.id
  client_id = keycloak_openid_client.minio.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.sikalabs_groups.name,
  ]
}
