terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_security_group" "sg" {
  count       = length(var.security_groups_config)
  name        = var.security_groups_config[count.index].name
  description = var.security_groups_config[count.index].description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.security_groups_config[count.index].ingress
    content {
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = ingress.value.cidr_blocks
      ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.security_groups_config[count.index].egress
    content {
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      cidr_blocks      = egress.value.cidr_blocks
      ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks
    }
  }

  tags = merge(
    var.security_groups_config[count.index].tags,
    { Name = var.security_groups_config[count.index].name }
  )
}
