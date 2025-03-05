output "security_group_ids" {
  description = "List of created security group IDs"
  value       = [for sg in aws_security_group.sg : sg.id]
}
