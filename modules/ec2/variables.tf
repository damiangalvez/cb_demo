variable "instance_count" {
  type        = number
  default     = 1
  description = "Number of EC2 instances to launch"
}

variable "ami_id" {
  type        = string
  description = "AMI to use for the EC2 instance"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "EC2 instance type"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs where to launch instances (will pick the first one if needed)"
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "List of security group IDs to attach"
}

variable "key_name" {
  type        = string
  default     = ""
  description = "Key pair name to attach (optional)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to attach to the instance"
}
