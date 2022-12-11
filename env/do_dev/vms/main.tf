locals {
  vms_generic = {
    # nfs = merge(local.template_nfs, {
    #   droplet_name = "nfs"
    #   record_name  = "nfs"
    # })
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
