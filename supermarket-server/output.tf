output "supermarket_server_hostname" {
  value = "${aws_instance.supermarket-server.public_dns}"
}
