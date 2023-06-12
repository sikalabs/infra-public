
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
  template_consul = merge(local.template_default, {
    user_data = local.consul_user_data
  })
  template_rke2 = {
    image     = local.IMAGE.DEBIAN
    region    = "fra1"
    size      = "s-2vcpu-4gb"
    user_data = local.default_user_data
    zone_id   = local.sikademo_com_zone_id
    ssh_keys  = local.ssh_keys
    vpc_uuid  = null
  }
  template_es = merge(local.template_default, {
    size = "s-2vcpu-4gb"
  })
  template_rke1 = merge(local.template_default, {
    size      = "s-2vcpu-4gb"
    image     = local.IMAGE.DOCKER
    user_data = local.user_data_rke1
  })
  template_kb = merge(local.template_default, {
    size = "s-1vcpu-2gb"
  })
  template_nfs = merge(local.template_default, {
    user_data = local.nfs_user_data
  })
  template_nginx = merge(local.template_default, {
    user_data = <<EOF
#cloud-config
runcmd:
  - |
    rm -rf /etc/update-motd.d/99-one-click
    apt-get update
    apt-get install -y curl sudo git mc htop vim tree
    curl -fsSL https://raw.githubusercontent.com/sikalabs/slu/master/install.sh | sudo sh
    apt-get install -y nginx
EOF
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
  consul_user_data  = <<EOF
#cloud-config
runcmd:
  - |
    rm -rf /etc/update-motd.d/99-one-click
    apt-get update
    apt-get install -y curl sudo git mc htop vim tree
    curl -fsSL https://raw.githubusercontent.com/sikalabs/slu/master/install.sh | sudo sh
    systemctl stop ufw
    systemctl disable ufw
    slu install-bin consul
EOF
  user_data_rke1    = <<EOF
#cloud-config
runcmd:
  - |
    rm -rf /etc/update-motd.d/99-one-click
    apt-get update
    apt-get install -y curl sudo git mc htop vim tree
    curl -fsSL https://raw.githubusercontent.com/sikalabs/slu/master/install.sh | sudo sh
    systemctl stop ufw
    systemctl disable ufw
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
write_files:
- path: /root/.ssh/id_rsa
  permissions: "0600"
  owner: root:root
  content: |
    -----BEGIN OPENSSH PRIVATE KEY-----
    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
    -----END OPENSSH PRIVATE KEY-----
- path: /root/.ssh/id_rsa.pub
  permissions: "0600"
  owner: root:root
  content: |
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQClalhUbYLKno7EPL8zsPj7pabTMGoyY/Ky88GK28SPVvxEy83vlv6fKlLYm8dTm4pWBtqJ0jPkmzgGFsavaV1BuX302qKa+v/Sv+ykC2k9zB0TV/2vkon8VkZoR2Tlyxp0NQ4V7CH9V1NUQxNdYhbQPeBxXwK7bgvwDHXgDKtgfsMt4Ij1r/my++5Cr3ZHtDTYb560wpIIggiZ6t/NsAjyepPc+ZbZkDzrui2A5T7g1OXtdq4nG1XDCffN3shL+hjj3AAjgNs6dVm/zAKIKGwNgOTwftLJv47JkcQe901G0eM10Ts5DpIJQPW/XTJUSj65BwjhY7Y/3YMdnxHrgcTbNKacFpgbdpFfCJ1ghdGmw+A4pp5DNB7YgEeDRJ3QIWuueif3SX2zeGi4Cm39kCUyS5ziJgePTvzGCspFvp4ox5Xm9phatyN7DsCNWvRI6w1cjcZFRn3Um6CFcXm5Sjs8wgafNVm88BzJRkQFCW04bO5qAj4x1HuZYhBNdWqOvgs= lab
- path: /root/.zshrc.default
  permissions: "0755"
  owner: root:root
  content: |
    export ZSH="$HOME/.oh-my-zsh"
    plugins=(git kube-ps1)
    ZSH_THEME=alanpeabody
    source $ZSH/oh-my-zsh.sh
    alias ondrejsika=". /root/.ondrejsika-dotfiles/core/zshrc"
- path: /root/.config/code-server/config.yaml
  permissions: "0755"
  owner: root:root
  content: |
    auth: password
    password: asdfasdf2020
    cert: false
- path: /root/.local/share/code-server/User/settings.json
  permissions: "0755"
  owner: root:root
  content: |
    {
      "terminal.integrated.shell.linux": "/bin/zsh"
    }
runcmd:
  - |
    rm -rf /etc/update-motd.d/99-one-click
    systemctl stop ufw
    systemctl disable ufw

    apt update

    # Zsh
    apt-get install -y zsh
    chsh -s /bin/zsh

    # Oh My Zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    cp /root/.zshrc.default /root/.zshrc

    # slu
    apt install -y curl
    curl -fsSL https://raw.githubusercontent.com/sikalabs/slu/master/install.sh | sh

    # code-server
    curl -fsSL https://code-server.dev/install.sh | HOME=/root sh
    systemctl enable --now code-server@root
    docker run -d --name proxy-80-8080 --net host sikalabs/slu:v0.50.0 slu proxy tcp -l :80 -r 127.0.0.1:8080
    docker run -d --name proxy-81-8080 --net host sikalabs/slu:v0.50.0 slu proxy tcp -l :81 -r 127.0.0.1:8080

    # apt-get install
    apt install -y sudo git mc redis-tools htop vim tree make

    # training-cli
    slu install-bin training-cli -v v0.5.0-dev-7

    # Ondrej Sika
    echo "source <(slu completion zsh)" >> /root/.zshrc
    echo "source <(training-cli completion zsh)" >> /root/.zshrc

    # Docker
    slu install-bin docker-compose
    slu install-bin crane
    slu install-bin reg

    # Kubernetes
    slu install-bin kubectl
    slu install-bin helm

    echo "source <(kubectl completion zsh)" >> /root/.zshrc
    echo "source <(helm completion zsh)" >> /root/.zshrc

    echo "alias k=kubectl" >> /root/.zshrc
    echo "alias kx=kubectx" >> /root/.zshrc
    echo "alias kn=kubens" >> /root/.zshrc

    # Terraform
    slu install-bin terraform

    # Aliases
    echo 'alias w="watch -n 0.3 "' >> /root/.zshrc
    echo 'alias dra="slu s dra"' >> /root/.zshrc

    # Elastic Stack
    slu install-bin filebeat

    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
    sudo apt-get install -y apt-transport-https
    echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list
    sudo apt-get update

    apt-get install --no-install-recommends -y python3 python3-pip

    # Ondrej Sika's Dotfiles
    git clone http://github.com/ondrejsika/dotfiles /root/.ondrejsika-dotfiles

    slu install-bin consul
    slu install-bin prometheus

    rm -rf /root/snap
EOF
}
