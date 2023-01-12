resource "grafana_data_source" "ondrejsika-prometheus-os" {
  provider = grafana.ondrejsika
  type     = "prometheus"
  uid      = "prometheus-os"
  name     = "prometheus-os"
  url      = "http://172.18.0.5:9090"
}
