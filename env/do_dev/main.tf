module "lab_okd" {
  source        = "./lab_okd"
  default_do_vm = local.default_do_vm
}

module "kuberneres" {
  source = "./kubernetes"
  config = {
    zone_ids = {
      "sikademo.com" = "f2c00168a7ecd694bb1ba017b332c019"
    }
  }
}

output "kubernetes" {
  value     = module.kuberneres
  sensitive = true
}
