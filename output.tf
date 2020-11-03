output "lightsail_instances" {
  value = {for key, val in module.lightsail : key => val.static_ip}
}
