variable "main_vpc_id" {
  type = string
}

variable "security_groups" {
  type = map(object({
    ingress_port_tcp        = optional(number)
    allowed_cidr_block      = optional(string)
    allow_all_egress        = optional(bool, false)
  }))
}

variable "sg_ingress_rules" {
  type = map(object({
    target_group = string
    source_group = string
    port         = number
  }))
}
