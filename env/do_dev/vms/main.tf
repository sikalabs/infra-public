locals {
  vms_generic = {
    # nfs = merge(local.template_nfs, {
    #   droplet_name = "nfs"
    #   record_name  = "nfs"
    # })
    # es = merge(local.template_es, {
    #   droplet_name = "es"
    #   record_name  = "es"
    # })
    # kb = merge(local.template_kb, {
    #   droplet_name = "kb"
    #   record_name  = "kb"
    # })
    # nginx0 = merge(local.template_nginx, {
    #   droplet_name = "nginx"
    #   record_name  = "nginx"
    # })
  }
  vms_generic_simple = {
    # example = merge(local.template_rke1, {}),
  }
  vms_lab = {
    # "0" = merge(local.template_lab, {})
  }
}

module "vms_generic" {
  source = "../../../modules/core/do_vm"

  for_each = local.vms_generic

  droplet_name = each.value.droplet_name
  record_name  = each.value.record_name
  image        = each.value.image
  region       = each.value.region
  size         = each.value.size
  user_data    = each.value.user_data
  zone_id      = each.value.zone_id
  vpc_uuid     = each.value.vpc_uuid
  ssh_keys     = each.value.ssh_keys
}

module "vms_generic_simple" {
  source = "../../../modules/core/do_vm"

  for_each = local.vms_generic_simple

  droplet_name = each.key
  record_name  = each.key
  image        = each.value.image
  region       = each.value.region
  size         = each.value.size
  user_data    = each.value.user_data
  zone_id      = each.value.zone_id
  vpc_uuid     = each.value.vpc_uuid
  ssh_keys     = each.value.ssh_keys
}

module "vms_lab" {
  source = "../../../modules/core/do_vm"

  for_each = local.vms_lab

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

resource "cloudflare_record" "vms_lab" {
  for_each = local.vms_lab

  zone_id = each.value.zone_id
  name    = "*.${module.vms_lab[each.key].cloudflare_record.name}"
  value   = module.vms_lab[each.key].cloudflare_record.hostname
  type    = "CNAME"
  proxied = false
}
