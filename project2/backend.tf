terraform {
  backend "s3" {
    bucket = "cbdemo-terraform-states"
    key    = "cb_demo/project2/terraform.tfstate"
    region = "us-east-1"
    # dynamodb_table = "terraform-locks"
  }
}
