provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "aws_instance" "chef-server" {
  ami             = "${var.ami}"
  instance_type   = "${var.instance_type}"
  key_name        = "${var.key_name}"
  subnet_id       = "${var.subnet_id}"
  vpc_security_group_ids = ["${split(",", var.vpc_security_group_ids)}"]

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /var/chef/cache"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file(\"${var.private_ssh_key_path}\")}"
    }
  }
}
