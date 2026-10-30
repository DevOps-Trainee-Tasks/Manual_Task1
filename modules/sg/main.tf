resource "aws_security_group" "security_groups" {
    for_each = var.security_groups
    name = each.key
    vpc_id = var.main_vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "cidr_ingress_rules" {
    for_each = {
    for group_name, group in var.security_groups :
    group_name => group
    if group.allowed_cidr_block != null
    }
   security_group_id = aws_security_group.security_groups[each.key].id
   ip_protocol = "tcp"
   from_port = each.value.ingress_port_tcp
   to_port = each.value.ingress_port_tcp
   cidr_ipv4 = each.value.allowed_cidr_block
}

resource "aws_vpc_security_group_ingress_rule" "first_security_group_ingress_rules" {
  for_each = {
    for group_name, group in var.security_groups :
    group_name => group
    if length(group.allowed_security_groups) > 0
  }

  security_group_id = aws_security_group.security_groups[each.key].id
  referenced_security_group_id = aws_security_group.security_groups[each.value.allowed_security_groups[0]].id
  ip_protocol = "tcp"
  from_port = each.value.ingress_port_tcp
  to_port = each.value.ingress_port_tcp
}

resource "aws_vpc_security_group_ingress_rule" "second_security_group_ingress_rules" {
  for_each = {
    for group_name, group in var.security_groups :
    group_name => group
    if length(group.allowed_security_groups) > 1
  }

  security_group_id = aws_security_group.security_groups[each.key].id
  referenced_security_group_id = aws_security_group.security_groups[each.value.allowed_security_groups[1]].id
  ip_protocol = "tcp"
  from_port = each.value.ingress_port_tcp
  to_port = each.value.ingress_port_tcp
}

resource "aws_vpc_security_group_egress_rule" "egress_rules" {
  for_each = {
    for group_name, group in var.security_groups :
    group_name => group
    if group.allow_all_egress
  }

  security_group_id = aws_security_group.security_groups[each.key].id
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"
}
