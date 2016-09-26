output "chef_server_hostname" {
  value = "${aws_instance.chef-server.public_dns}"
}

output "chef_server_public_ip" {
  value = "${aws_instance.chef-server.public_dns}"
}
