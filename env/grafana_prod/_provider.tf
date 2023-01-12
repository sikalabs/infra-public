terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "1.33.0"
    }
  }
}

variable "grafana_url" {
  type        = string
  description = "Grafana URL"
}

variable "grafana_auth" {
  type        = string
  description = "Grafana Auth (admin:password or token)"
}

provider "grafana" {
  url  = var.grafana_url
  auth = var.grafana_auth
}

provider "grafana" {
  url    = var.grafana_url
  auth   = var.grafana_auth
  org_id = grafana_organization.sikalabs.org_id
  alias  = "sikalabs"
}

provider "grafana" {
  url    = var.grafana_url
  auth   = var.grafana_auth
  org_id = grafana_organization.ondrejsika.org_id
  alias  = "ondrejsika"
}

provider "grafana" {
  url    = var.grafana_url
  auth   = var.grafana_auth
  org_id = grafana_organization.ondrejsika-manual.org_id
  alias  = "ondrejsika-manual"
}
