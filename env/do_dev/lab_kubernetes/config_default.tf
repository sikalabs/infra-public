locals {
  default_user_data = <<EOF
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
EOF
  vm_templates = {
    lab = merge(var.default_do_vm, {
      image        = "docker-20-04"
      size         = "s-2vcpu-4gb"
      droplet_name = "lab-k8s-"
      record_name  = "lab"
      user_data    = local.default_user_data
    })
  }
}
