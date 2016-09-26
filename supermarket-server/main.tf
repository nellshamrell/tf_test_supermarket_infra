provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "aws_instance" "supermarket-server" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  subnet_id       = "${var.subnet_id}"
  vpc_security_group_ids = ["${split(",", var.vpc_security_group_ids)}"]
  tags {
    Name = "supermarket-server"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get install apt-transport-https",
      "wget -qO - https://downloads.chef.io/packages-chef-io-public.key | sudo apt-key add -",
      "echo \"deb https://packages.chef.io/current-apt trusty main\" > chef-current.list",
      "sudo mv chef-current.list /etc/apt/sources.list.d",
      "sudo apt-get update",
      "sudo apt-get install supermarket",
      "sudo supermarket-ctl reconfigure"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file(\"${var.private_ssh_key_path}\")}"
    }
  }
}
