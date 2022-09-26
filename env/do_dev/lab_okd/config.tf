locals {
  vms = {
    "0" = merge(local.vm_templates.lab, {})
    "1" = merge(local.vm_templates.lab, {})
    "2" = merge(local.vm_templates.lab, {})
    "3" = merge(local.vm_templates.lab, {})
  }
}
