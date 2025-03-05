# VPC Module
Creates:
- A VPC
- Public subnets
- Private subnets

## Usage

module "vpc" {
  source = "../modules/vpc"

  name                    = "my-vpc"
  cidr_block             = "10.0.0.0/16"
  public_subnets_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidrs  = ["10.0.11.0/24", "10.0.12.0/24"]
  tags = {
    Owner       = "DevOps"
    Environment = "dev"
  }
}
