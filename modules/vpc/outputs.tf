output "vpc_id" {
  value       = aws_vpc.this.id
  description = "The ID of the VPC"
}

output "public_subnets" {
  value       = [for s in aws_subnet.public : s.id]
  description = "IDs of public subnets"
}

output "private_subnets" {
  value       = [for s in aws_subnet.private : s.id]
  description = "IDs of private subnets"
}
