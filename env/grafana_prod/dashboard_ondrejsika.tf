resource "grafana_dashboard" "ondrejsika-uptime" {
  provider    = grafana.ondrejsika
  config_json = file("./dashboards/uptime.json")
}

resource "grafana_dashboard" "ondrejsika-uptime-error-only" {
  provider    = grafana.ondrejsika
  config_json = file("./dashboards/uptime-error-only.json")
}

resource "grafana_dashboard" "ondrejsika-prometheus-alerts" {
  provider    = grafana.ondrejsika
  config_json = file("./dashboards/prometheus-alerts.json")
}
