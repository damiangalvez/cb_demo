# Security Groups Module
Creates multiple security groups based on a configurable list of ingress/egress rules.

## Usage

module "security_groups" {
  source = "../modules/security-groups"
  vpc_id = module.vpc.vpc_id
  security_groups_config = [
    {
      name        = "public-sg"
      description = "Allow inbound HTTP from anywhere"
      ingress = [{
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
      }]
      egress = [{
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
      }]
      tags = {
        Project = "demo"
      }
    }
  ]
}
