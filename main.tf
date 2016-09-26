provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

module "chef-server" {
  source = "./chef-server"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
  subnet_id = "${var.subnet_id}"

  vpc_security_group_ids = "${var.vpc_security_group_ids}"

  key_name = "${var.key_name}"
  private_ssh_key_path = "${var.private_ssh_key_path}"
  chef-server-user = "${var.chef-server-user}"
  chef-server-user-full-name = "${var.chef-server-user-full-name}"
  chef-server-user-email = "${var.chef-server-user-email}"
  chef-server-user-password = "${var.chef-server-user-password}"
  chef-server-org-name = "${var.chef-server-org-name}"
  chef-server-org-full-name = "${var.chef-server-org-full-name}"
}

module "supermarket-server" {
  source = "./supermarket-server"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
  subnet_id = "${var.subnet_id}"

  vpc_security_group_ids = "${var.vpc_security_group_ids}"

  private_ssh_key_path = "${var.private_ssh_key_path}"
  key_name = "${var.key_name}"
}

resource "null_resource" "chef_server_oc_id_setup" {
  # Temporarily change ownership of /etc/opscode/chef-server.rb to ubuntu so we can edit it through ssh
  provisioner "local-exec" {
    command = "ssh -oStrictHostKeyChecking=no -i ${var.private_ssh_key_path} ubuntu@${module.chef-server.chef_server_hostname} sudo chown ubuntu /etc/opscode/chef-server.rb "
  }

  provisioner "local-exec" {
    command = <<EOT
      ssh -i ${var.private_ssh_key_path} ubuntu@${module.chef-server.chef_server_hostname} 'echo \oc_id[\"applications\"] = { \"supermarket\" =\> { \"redirect_uri\" =\> \"https://${module.supermarket-server.supermarket_server_hostname}/auth/chef_oauth2/callback\" } } >> /etc/opscode/chef-server.rb'
    EOT
  }

  provisioner "local-exec" {
    command = "ssh -i ${var.private_ssh_key_path} ubuntu@${module.chef-server.chef_server_hostname} sudo chown root /etc/opscode/chef-server.rb "
  }

  provisioner "local-exec" {
    command = "ssh -i ${var.private_ssh_key_path} ubuntu@${module.chef-server.chef_server_hostname} sudo chef-server-ctl reconfigure"
  }
}
