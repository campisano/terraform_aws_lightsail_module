output "static_ip" {
  value = var.static_ip ? aws_lightsail_static_ip.static_ip[0].ip_address : "null"
}
