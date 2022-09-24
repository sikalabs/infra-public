locals {
  vm_templates = {
    example = merge(local.default_do_vm, {
      droplet_name = "example"
      record_name  = "example"
      size         = "s-1vcpu-2gb"
    })
  }
  vms = {
  }
}
