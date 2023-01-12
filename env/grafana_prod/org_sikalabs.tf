resource "grafana_organization" "sikalabs" {
  name = "sikalabs"
  admins = [
    grafana_user.ondrej-admin.email,
  ]
  editors = []
  viewers = [
    grafana_user.ondrej.email,
  ]
}

module "home_dashboard-sikalabs" {
  providers = {
    grafana = grafana.sikalabs
  }
  source = "../../modules/grafana/home_dashboard"
  title  = "SikaLabs (terraform)"
}

resource "grafana_organization_preferences" "sikalabs" {
  provider = grafana.sikalabs
  depends_on = [
    module.home_dashboard-sikalabs,
  ]
  lifecycle {
    ignore_changes = [
      home_dashboard_id,
    ]
  }
  home_dashboard_uid = "home"
}
