terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# 1. VPC Module
module "vpc" {
  source                = "../modules/vpc"
  name                  = "project2-vpc"
  cidr_block            = "10.20.0.0/16"
  public_subnets_cidrs  = ["10.20.1.0/24", "10.20.2.0/24"]
  private_subnets_cidrs = ["10.20.11.0/24", "10.20.12.0/24"]
  tags = {
    Project = "project2"
  }
}

# 2. IAM Roles Module
data "aws_iam_policy_document" "assume_ec2" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ec2_readonly" {
  statement {
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }
}

module "iam_roles" {
  source             = "../modules/iam-roles"
  role_name          = "project2-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.assume_ec2.json
  policy_name        = "ec2-readonly-policy"
  policy_document    = data.aws_iam_policy_document.ec2_readonly.json
  tags = {
    Project = "project2"
  }
}

# 3. Security Groups Module
module "security_groups" {
  source = "../modules/security-groups"
  vpc_id = module.vpc.vpc_id

  security_groups_config = [
    {
      name        = "public-sg"
      description = "Allow inbound HTTP from anywhere"
      ingress = [
        {
          from_port        = 80
          to_port          = 80
          protocol         = "tcp"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = ["::/0"]
        }
      ]
      egress = [
        {
          from_port        = 0
          to_port          = 0
          protocol         = "-1"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = ["::/0"]
        }
      ]
      tags = {
        Project = "project2"
      }
    }
  ]
}

# 4. EC2 Module
module "ec2" {
  source             = "../modules/ec2"
  instance_count     = 1
  ami_id             = "ami-05b10e08d247fb927" # Amazon Linux 2023 AMI - (64-bit (x86), uefi-preferred)
  instance_type      = "t3.micro"
  subnet_ids         = module.vpc.private_subnets
  security_group_ids = module.security_groups.security_group_ids
  key_name           = "" # Replace with the key pair name or leave it blank
  tags = {
    Project = "project2"
  }
}
