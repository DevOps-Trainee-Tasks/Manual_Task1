variable "main_vpc_id" {
  type = string
}

variable "security_groups" {
  type = map(object({
    ingress_port_tcp        = number
    allowed_cidr_block      = optional(string)
    allowed_security_groups = optional(list(string), [])
    allow_all_egress        = optional(bool, false)
  }))
}

