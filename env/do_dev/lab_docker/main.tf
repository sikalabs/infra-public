variable "default_do_vm" {}

module "vms" {
  source = "../../../modules/core/do_vm"

  for_each = local.vms

  droplet_name = "${each.value.droplet_name}${each.key}"
  record_name  = "${each.value.record_name}${each.key}"
  image        = each.value.image
  region       = each.value.region
  size         = each.value.size
  user_data    = each.value.user_data
  zone_id      = each.value.zone_id
  vpc_uuid     = each.value.vpc_uuid
  ssh_keys     = each.value.ssh_keys
}

terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}


resource "cloudflare_record" "this_wildcard" {
  for_each = local.vms

  zone_id = each.value.zone_id
  name    = "*.${each.value.record_name}${each.key}"
  value   = "${each.value.record_name}${each.key}.sikademo.com"
  type    = "CNAME"
  proxied = false
}
