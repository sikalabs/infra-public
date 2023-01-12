resource "grafana_organization" "ondrejsika" {
  name = "ondrejsika"
  admins = [
    grafana_user.ondrej-admin.email,
  ]
  editors = []
  viewers = [
    grafana_user.ondrej.email,
  ]
}

module "home_dashboard-ondrejsika" {
  source = "../../modules/grafana/home_dashboard"
  providers = {
    grafana = grafana.ondrejsika
  }
  title = "Ondrej Sika (terraform)"
}

resource "grafana_organization_preferences" "ondrejsika" {
  provider = grafana.ondrejsika
  depends_on = [
    module.home_dashboard-ondrejsika,
  ]
  lifecycle {
    ignore_changes = [
      home_dashboard_id,
    ]
  }
  home_dashboard_uid = "home"
}
