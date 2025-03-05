output "role_arn" {
  value       = aws_iam_role.this.arn
  description = "ARN of the created IAM role"
}

output "policy_arn" {
  value       = aws_iam_policy.this.arn
  description = "ARN of the attached IAM policy"
}
