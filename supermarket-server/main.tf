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
      "wget https://packages.chef.io/stable/ubuntu/14.04/supermarket_2.8.25-1_amd64.deb",
      "sudo dpkg -i supermarket_2.8.25-1_amd64.deb",
      "sudo supermarket-ctl reconfigure"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file(\"${var.private_ssh_key_path}\")}"
    }
  }
}
