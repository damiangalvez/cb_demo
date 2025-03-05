# Project1-specific outputs
output "ec2_instance_ids" {
  description = "EC2 instance IDs for project1"
  value       = module.ec2.instance_ids
}

output "ec2_public_ips" {
  description = "Public IPs of the EC2 instances (if assigned)"
  value       = module.ec2.public_ips
}
