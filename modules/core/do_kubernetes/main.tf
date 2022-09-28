terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

variable "cluster_name" {}
variable "record_name" {}
variable "region" {}
variable "node_size" {}
variable "node_count" {}
variable "kubernetes_version" {}
variable "zone_id" {}
variable "enable_proxy_protocol" {}

resource "digitalocean_kubernetes_cluster" "this" {
  name   = var.cluster_name
  region = var.region

  // Get available versions using: doctl kubernetes options versions
  version = var.kubernetes_version

  node_pool {
    name       = var.cluster_name
    size       = var.node_size
    node_count = var.node_count
  }
}

resource "digitalocean_loadbalancer" "this" {
  name   = var.cluster_name
  region = var.region

  enable_proxy_protocol = var.enable_proxy_protocol

  droplet_tag = "k8s:${digitalocean_kubernetes_cluster.this.id}"

  healthcheck {
    port     = 80
    protocol = "tcp"
  }

  forwarding_rule {
    entry_port      = 80
    target_port     = 80
    entry_protocol  = "tcp"
    target_protocol = "tcp"
  }

  forwarding_rule {
    entry_port      = 443
    target_port     = 443
    entry_protocol  = "tcp"
    target_protocol = "tcp"
  }

  forwarding_rule {
    entry_port      = 8080
    target_port     = 30003
    entry_protocol  = "tcp"
    target_protocol = "tcp"
  }

  forwarding_rule {
    entry_port      = 25
    target_port     = 30025
    entry_protocol  = "tcp"
    target_protocol = "tcp"
  }
}

resource "cloudflare_record" "this" {
  zone_id = var.zone_id
  name    = var.record_name
  value   = digitalocean_loadbalancer.this.ip
  type    = "A"
  proxied = false
}

resource "cloudflare_record" "this_wildcard" {
  zone_id = var.zone_id
  name    = "*.${var.record_name}"
  value   = digitalocean_loadbalancer.this.ip
  type    = "A"
  proxied = false
}

output "loadbalancer_ip" {
  value = digitalocean_loadbalancer.this.ip
}

output "loadbalancer_fqdn" {
  value = cloudflare_record.this.hostname
}

output "kubeconfig" {
  value     = digitalocean_kubernetes_cluster.this.kube_config.0.raw_config
  sensitive = true
}

output "digitalocean_kubernetes_cluster" {
  value = digitalocean_kubernetes_cluster.this
}

output "digitalocean_loadbalancer" {
  value = digitalocean_loadbalancer.this
}
