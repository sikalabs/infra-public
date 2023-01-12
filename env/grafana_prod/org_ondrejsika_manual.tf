resource "grafana_organization" "ondrejsika-manual" {
  name = "ondrejsika-manual"
  admins = [
    grafana_user.ondrej-admin.email,
    grafana_user.ondrej.email,
  ]
  editors = []
  viewers = []
}

module "home_dashboard-ondrejsika-manual" {
  source = "../../modules/grafana/home_dashboard"
  providers = {
    grafana = grafana.ondrejsika-manual
  }
  title = "Ondrej Sika (manual)"
}

resource "grafana_organization_preferences" "ondrejsika-manual" {
  provider = grafana.ondrejsika-manual
  depends_on = [
    module.home_dashboard-ondrejsika-manual,
  ]
  lifecycle {
    ignore_changes = [
      home_dashboard_id,
    ]
  }
  home_dashboard_uid = "home"
}
