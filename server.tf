data "aws_ami" "ubuntu-xenial" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "mc-server" {
  ami = "${data.aws_ami.ubuntu-xenial.id}"
  instance_type = "t3.medium"
  key_name = "${aws_key_pair.rsa.key_name}"

  security_groups = [
    "${aws_security_group.https.name}",
    "${aws_security_group.http-ssh.name}",
    "${aws_security_group.admin.name}",
    "${aws_security_group.mc.name}",
  ]

  provisioner "file" {
    connection {
      type     = "ssh"
      user     = "ubuntu"
    }

    source      = "support/"
    destination = "/home/ubuntu/"
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "ubuntu"
    }

    inline = [
      "sudo add-apt-repository -y ppa:webupd8team/java",
      "curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -",
      "sudo apt update",
      # download the necessary prerequisite components for mineos
      "sudo apt -y install -y nodejs git rdiff-backup screen build-essential",
      # fucking JAVA
      "sudo apt install -y python-software-properties debconf-utils",
      "echo 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select true' | sudo debconf-set-selections",
      "sudo apt install -y oracle-java8-installer",
      "sudo npm install -g yarn",
      # go via snap
      "sudo snap install --classic go",
      # caddy
      "sudo sh -c \"go get github.com/mholt/caddy/caddy\"",
      "sudo sh -c \"go install github.com/mholt/caddy/caddy\"",
      "sudo mv ~/go/bin/caddy /usr/bin",
      "sudo chmod ugo+x /usr/bin/caddy",
      # .config is owned by root ????
      "sudo chown ubuntu /home/ubuntu/.config",
      # download the most recent mineos web-ui files from github
      "mkdir -p /usr/games",
      "sudo chown ubuntu /usr/games",
      "cd /usr/games",
      "git clone https://github.com/hexparrot/mineos-node.git minecraft",
      "cd minecraft",
      "git config core.filemode false",
      "chmod +x service.js mineos_console.js generate-sslcert.sh webui.js",
      "sudo ln -s /usr/games/minecraft/mineos_console.js /usr/local/bin/mineos",
      "yarn",
      # download latest backup
      "wget https://s3-eu-west-1.amazonaws.com/hotelbraganca-club-backups/latest.tgz",
      "sudo mkdir -p /var/games/minecraft/servers/HOTELBRAGANCA.CLUB",
      "sudo tar xvf ./latest.tgz -C /var/games/minecraft/servers/HOTELBRAGANCA.CLUB",
      "sudo chown -R ubuntu:ubuntu /var/games/minecraft/servers/HOTELBRAGANCA.CLUB",
      # distribute service related files
      "sudo cp init/systemd_conf /etc/systemd/system/mineos.service",
      # bring her home, boys
      "sudo mv /home/ubuntu/caddy.service /etc/systemd/system/caddy.service",
      "sudo mv /home/ubuntu/mineos.conf /etc/mineos.conf",
      "sudo chmod +x /home/ubuntu/upload_to_s3.sh",
      "sudo systemctl enable caddy mineos",
      "sudo systemctl start caddy mineos",
    ]
  }
}

output "mc-admin-url" {
  value = "ssh://ubuntu@${aws_instance.mc-server.public_ip}"
}
