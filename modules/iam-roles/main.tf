terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = var.assume_role_policy

  tags = merge(
    var.tags,
    { Name = var.role_name }
  )
}

resource "aws_iam_policy" "this" {
  name        = var.policy_name
  policy      = var.policy_document
  description = "Custom policy for ${var.role_name}"
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
