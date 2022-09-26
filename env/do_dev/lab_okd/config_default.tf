locals {
  default_user_data = <<EOF
#cloud-config
ssh_pwauth: yes
password: asdfasdf1234
chpasswd:
  expire: false
write_files:
- path: /usr/local/bin/k
  permissions: "0755"
  owner: root:root
  content: |
    #!/bin/sh
    kubectl $@
runcmd:
  - |
    rm -rf /etc/update-motd.d/99-one-click
    apt-get update
    apt-get install -y curl sudo git mc htop vim tree
    curl -fsSL https://raw.githubusercontent.com/sikalabs/slu/master/install.sh | sudo sh
    install-slu install --version v0.52.0-dev-1
    slu install-bin oc
    slu install-bin openshift-install
    slu install-bin kubectl
    slu install-bin helm
    mkdir -p /root/training
    git clone https://github.com/ondrejsika/okd-training /root/training/okd
    git clone https://github.com/ondrejsika/kubernetes-training /root/training/kubernetes
EOF
  vm_templates = {
    lab = merge(var.default_do_vm, {
      droplet_name = "lab-okd-"
      record_name  = "lab"
      user_data    = local.default_user_data
    })
  }
}
