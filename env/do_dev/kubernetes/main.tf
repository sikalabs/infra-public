module "kubernetes" {
  for_each = local.kubernetes
  source   = "../../../modules/core/do_kubernetes"

  cluster_name          = each.value.cluster_name
  record_name           = each.value.record_name
  region                = each.value.region
  node_size             = each.value.node_size
  node_count            = each.value.node_count
  kubernetes_version    = each.value.kubernetes_version
  zone_id               = each.value.zone_id
  enable_proxy_protocol = each.value.enable_proxy_protocol
}

output "kubeconfigs" {
  value = {
    for k, v in module.kubernetes : k => v.kubeconfig
  }
  sensitive = true
}

resource "local_sensitive_file" "kubeconfigs" {
  for_each = module.kubernetes
  filename = "${path.module}/kubeconfig/kubeconfig.${each.key}.yml"
  content  = each.value.kubeconfig
}
