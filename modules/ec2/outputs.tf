output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = [for i in aws_instance.this : i.id]
}

output "public_ips" {
  description = "List of public IPs (if available)"
  value       = [for i in aws_instance.this : i.public_ip]
}
