output "chef_server_hostname" {
  value = "${module.chef-server.chef_server_hostname}"
}

output "supermarket_server_hostname" {
  value = "${module.supermarket-server.supermarket_server_hostname}"
}
