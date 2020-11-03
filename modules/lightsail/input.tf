variable "name"         { type = string }
variable "zone"         { type = string }
variable "keypair_name" { type = string }
variable "blueprint_id" { type = string }
variable "bundle_id"    { type = string }
variable "static_ip"    {
  type = bool
  default = false
}
variable "init_script"  {
  type = string
  default = null
}
