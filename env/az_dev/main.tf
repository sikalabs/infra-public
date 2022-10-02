module "storage" {
  source = "./storage"
}

output "storage" {
  value     = module.storage
  sensitive = true
}
