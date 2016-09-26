output "supermarket_server_hostname" {
  value = "${aws_instance.supermarket-server.public_dns}"
}

output "supermarket_server_public_ip" {
  value = "${aws_instance.supermarket-server.public_ip}"
}
