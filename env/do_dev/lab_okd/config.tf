locals {
  vms = {
    "0" = merge(local.vm_templates.lab, {})
  }
}
