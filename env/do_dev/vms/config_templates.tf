
locals {
  template_default = {
    image     = local.IMAGE.DEBIAN
    region    = "fra1"
    size      = "s-1vcpu-1gb"
    user_data = local.default_user_data
    zone_id   = local.sikademo_com_zone_id
    ssh_keys  = local.ssh_keys
    vpc_uuid  = null
  }
  template_nfs = merge(local.template_default, {
    user_data = local.nfs_user_data
  })
  template_lab = merge(local.template_default, {
    image        = local.IMAGE.DOCKER
    size         = "s-2vcpu-4gb"
    droplet_name = "lab"
    record_name  = "lab"
    user_data    = local.lab_user_data
  })
  default_user_data = <<EOF
#cloud-config
runcmd:
  - |
    rm -rf /etc/update-motd.d/99-one-click
    apt-get update
    apt-get install -y curl sudo git mc htop vim tree
    curl -fsSL https://raw.githubusercontent.com/sikalabs/slu/master/install.sh | sudo sh
EOF
  nfs_user_data     = <<EOF
#cloud-config
runcmd:
  - |
    rm -rf /etc/update-motd.d/99-one-click
    apt-get update
    apt-get install -y curl sudo git mc htop vim tree
    curl -fsSL https://raw.githubusercontent.com/sikalabs/slu/master/install.sh | sudo sh
    apt-get update
    apt-get install -y nfs-kernel-server
    mkdir /nfs
    echo '/nfs *(rw,no_root_squash,insecure)' > /etc/exports
    systemctl restart nfs-kernel-server
EOF
  lab_user_data     = <<EOF
#cloud-config
ssh_pwauth: yes
password: asdfasdf2020
chpasswd:
  expire: false
write_files:
- path: /usr/local/bin/k
  permissions: "0755"
  owner: root:root
  content: |
    #!/bin/sh
    kubectl $@
- path: /root/.config/code-server/config.yaml
  permissions: "0755"
  owner: root:root
  content: |
    auth: password
    password: asdfasdf2020
    cert: false
runcmd:
  - |
    rm -rf /etc/update-motd.d/99-one-click
    apt update
    apt install -y curl sudo git mc redis-tools htop vim tree
    systemctl stop ufw
    systemctl disable ufw
    curl -fsSL https://raw.githubusercontent.com/sikalabs/slu/master/install.sh | sudo sh
    slu install-bin training-cli -v v0.5.0-dev-7
    HOME=/root training-cli kubernetes vm-setup
    curl -fsSL https://code-server.dev/install.sh | HOME=/root sh
    systemctl enable --now code-server@root
    docker run -d --name proxy-8080 --net host sikalabs/slu:v0.50.0 slu proxy tcp -l :80 -r 127.0.0.1:8080
    # Docker
    slu install-bin crane
    slu install-bin reg
    
EOF
}
