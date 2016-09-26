output "chef_server_hostname" {
  value = "${module.chef-server.chef_server_hostname}"
}

output "chef_server_public_ip" {
  value = "${module.chef-server.chef_server_public_ip}"
}

output "supermarket_server_hostname" {
  value = "${module.supermarket-server.supermarket_server_hostname}"
}

output "supermarket_server_public_ip" {
  value = "${module.supermarket-server.supermarket_server_public_ip}"
}

output "cluster_hostnames" {
  value = "${module.chef_server_hostname},${module.supermarket_server_hostname}"
}
