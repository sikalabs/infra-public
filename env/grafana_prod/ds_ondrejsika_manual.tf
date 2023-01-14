resource "grafana_data_source" "ondrejsika-manual-prometheus-os" {
  provider = grafana.ondrejsika-manual
  type     = "prometheus"
  uid      = "prometheus-os"
  name     = "prometheus-os"
  url      = "http://172.18.0.5:9090"
}

resource "grafana_data_source" "ondrejsika-manual-elasticsearch-joh" {
  provider            = grafana.ondrejsika-manual
  type                = "elasticsearch"
  uid                 = "elasticsearch-joh"
  name                = "elasticsearch-joh"
  url                 = "https://es-joh.sl.zone"
  basic_auth_enabled  = true
  basic_auth_username = "elastic"
  json_data_encoded = jsonencode(
    {
      esVersion                  = "8.0.0"
      includeFrozen              = false
      logLevelField              = ""
      logMessageField            = ""
      maxConcurrentShardRequests = 5
      timeField                  = "@timestamp"
      logMessageField            = "message"
    }
  )
  secure_json_data_encoded = jsonencode({
    basicAuthPassword = var.kibana_joh_password
  })
}

resource "grafana_data_source" "ondrejsika-manual-postgres-tergum_telemetry" {
  provider = grafana.ondrejsika-manual
  type     = "postgres"
  name     = "Tergum Telemetry DB"
  uid      = "postgres-tergum_telemetry"

  url           = "db0.oxs.cz"
  username      = "postgres"
  database_name = "tergum_telemetry"

  json_data_encoded = jsonencode({
    "postgresVersion" = 1000
    "sslmode"         = "disable"
  })

  secure_json_data_encoded = jsonencode({
    "password" = "thisispostgresbaby"
  })
}
