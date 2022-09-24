locals {
  vm_templates = {
    example = merge(local.default_do_vm, {
      droplet_name = "example"
      record_name  = "example"
      size         = "s-1vcpu-2gb"
    })
    crc = merge(local.default_do_vm, {
      droplet_name = "crc"
      record_name  = "crc"
      size         = "s-8vcpu-16gb"
    })
  }
  vms = {
    crc = local.vm_templates.crc
  }
}
