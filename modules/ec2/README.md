# EC2 Module
Launches one or more EC2 instances with specified AMI, instance type, and security groups.

## Usage

module "ec2" {
  source              = "../modules/ec2"
  instance_count      = 2
  ami_id              = "ami-1234567890abcdef0"
  instance_type       = "t3.small"
  subnet_ids          = module.vpc.private_subnets
  security_group_ids  = module.security_groups.security_group_ids
  key_name            = "my_key_pair"
  tags = {
    Project = "my_app"
  }
}
