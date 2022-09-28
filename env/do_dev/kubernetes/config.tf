locals {
  DEFAULT = {
    // Get available regions using: doctl kubernetes options regions
    REGION = "fra1"
    // Get available versions using: doctl kubernetes options versions
    KUBERNETES_VERSION = "1.24.4-do.0"
    // Get available sizes using: doctl kubernetes options sizes
    NODE_SIZE = "s-4vcpu-8gb"
    ZONE_ID   = var.config.zone_ids["sikademo.com"]
  }
}

locals {
  default = {
    region                = local.DEFAULT.REGION
    node_size             = local.DEFAULT.NODE_SIZE
    node_count            = 3
    kubernetes_version    = local.DEFAULT.KUBERNETES_VERSION
    zone_id               = local.DEFAULT.ZONE_ID
    enable_proxy_protocol = true
  }
}

locals {
  kubernetes = {
    "0" = merge(local.default, {
      cluster_name = "k8s-0"
      record_name  = "k8s-0"
    })
  }
}
