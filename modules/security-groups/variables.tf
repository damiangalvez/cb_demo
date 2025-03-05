variable "vpc_id" {
  type        = string
  description = "ID of the VPC to create security groups in"
}

variable "security_groups_config" {
  type = list(object({
    name        = string
    description = string
    ingress     = list(object({
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = list(string)
      ipv6_cidr_blocks = list(string)
    }))
    egress = list(object({
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = list(string)
      ipv6_cidr_blocks = list(string)
    }))
    tags = map(string)
  }))
  default     = []
  description = "List of security group configurations"
}
