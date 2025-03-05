terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_instance" "this" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type

  # If multiple subnets are provided, just pick the first one for now:
  subnet_id = length(var.subnet_ids) > 0 ? var.subnet_ids[0] : null

  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name != "" ? var.key_name : null

  tags = merge(
    var.tags,
    { Name = "${var.tags["Project"] != "" ? var.tags["Project"] : "ec2-instance"}-${count.index}" }
  )
}
