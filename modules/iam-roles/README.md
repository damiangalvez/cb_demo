# IAM Roles Module
Creates a single IAM role and attaches a specified policy.

## Usage

module "iam_roles" {
  source             = "../modules/iam-roles"
  role_name          = "my-sample-role"
  assume_role_policy = data.aws_iam_policy_document.assume_ec2.json
  policy_name        = "my-custom-policy"
  policy_document    = data.aws_iam_policy_document.ec2_readonly.json
  tags = {
    Project = "sample"
  }
}

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
