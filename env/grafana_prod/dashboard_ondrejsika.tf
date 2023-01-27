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

resource "grafana_dashboard" "ondrejsika-logs-all" {
  provider    = grafana.ondrejsika
  config_json = file("./dashboards/logs-all.json")
}

resource "grafana_dashboard" "ondrejsika-tergum" {
  provider    = grafana.ondrejsika
  config_json = file("./dashboards/tergum.json")
}

resource "grafana_dashboard" "ondrejsika-nginx-ingress-9614" {
  provider    = grafana.ondrejsika
  config_json = file("./dashboards/nginx-ingress-9614.json")
}
