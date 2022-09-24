module "vms" {
  source = "../../modules/core/do_vm"

  for_each = local.vms

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
