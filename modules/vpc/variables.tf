variable "cidr" {
  type = string
}

variable "available_zones_list" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "private_db_subnets" {
  type = list(string)
}

variable "private_servers_subnets" {
  type = list(string)
}