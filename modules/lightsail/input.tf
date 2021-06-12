variable "aws_profile"        { type = string }
variable "name"               { type = string }
variable "zone"               { type = string }
variable "keypair_name"       { type = string }
variable "blueprint_id"       { type = string }
variable "bundle_id"          { type = string }
variable "static_ip"          {
  type    = bool
  default = false
}
variable "init_script_path"   {
  type    = string
  default = null
}
variable "public_ports_rules" {
  type    = string
  default = null
}
