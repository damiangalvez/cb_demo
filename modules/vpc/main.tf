terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = merge(
    var.tags,
    { Name = "${var.name}-vpc" }
  )
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets_cidrs)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    { Name = "${var.name}-public-${count.index}" }
  )
}

resource "aws_subnet" "private" {
  count              = length(var.private_subnets_cidrs)
  vpc_id             = aws_vpc.this.id
  cidr_block         = var.private_subnets_cidrs[count.index]
  availability_zone  = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    var.tags,
    { Name = "${var.name}-private-${count.index}" }
  )
}
