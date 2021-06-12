data "template_file" "init_script" {
  count = var.init_script_path != null ? 1 : 0

  template = file(var.init_script_path)
}

resource "aws_lightsail_instance" "instance" {
  name              = var.name
  availability_zone = var.zone
  key_pair_name     = var.keypair_name
  blueprint_id      = var.blueprint_id
  bundle_id         = var.bundle_id
  user_data         = var.init_script_path != null ? data.template_file.init_script[0].rendered : null
}

resource "aws_lightsail_static_ip" "static_ip" {
  count = var.static_ip ? 1 : 0

  name = "${var.name}_static_ip"
}

resource "aws_lightsail_static_ip_attachment" "static_ip_att" {
  count = var.static_ip ? 1 : 0

  static_ip_name = aws_lightsail_static_ip.static_ip[0].name
  instance_name  = aws_lightsail_instance.instance.name
}

resource "null_resource" "firewall" {
  count = var.public_ports_rules != null ? 1 : 0

  provisioner "local-exec" {
    command = "aws --profile ${var.aws_profile} lightsail put-instance-public-ports --instance-name=${aws_lightsail_instance.instance.name} --port-infos ${var.public_ports_rules}"
  }
}
