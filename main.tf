module "lightsail" {
  source = "./modules/lightsail"

  for_each = var.lightsail

  aws_profile        = var.aws.profile
  name               = each.key
  zone               = each.value.zone
  keypair_name       = each.value.keypair_name
  blueprint_id       = each.value.blueprint_id
  bundle_id          = each.value.bundle_id
  static_ip          = lookup(each.value, "static_ip", false)
  init_script        = lookup(each.value, "init_script", null)
  public_ports_rules = lookup(each.value, "public_ports_rules", null)
}
