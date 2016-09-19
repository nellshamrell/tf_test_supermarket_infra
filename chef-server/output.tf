output "chef_server_hostname" {
  value = "${aws_instance.chef-server.public_dns}"
}
