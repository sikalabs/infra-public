variable "droplet_name" {}
variable "record_name" {}
variable "image" {
  default = "debian-11-x64"
}
variable "region" {
  default = "fra1"
}
variable "size" {
  default = "s-1vcpu-1gb"
}
variable "user_data" {
  default = null
}
variable "zone_id" {}
variable "ssh_keys" {
  default = []
}
variable "vpc_uuid" {
  default = null
}

module "this" {
  source = "../../core/do_vm"

  image        = var.image
  droplet_name = var.droplet_name
  record_name  = var.record_name
  zone_id      = var.zone_id
  region       = var.region
  size         = var.size
  user_data    = var.user_data
  vpc_uuid     = var.vpc_uuid
  ssh_keys     = var.ssh_keys
}

output "digitalocean_droplet" {
  value = module.this.digitalocean_droplet
}

output "cloudflare_record" {
  value = module.this.cloudflare_record
}
