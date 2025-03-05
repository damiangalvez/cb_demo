variable "name" {
  type        = string
  description = "Name prefix for the VPC"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnets_cidrs" {
  type        = list(string)
  description = "List of CIDRs for public subnets"
}

variable "private_subnets_cidrs" {
  type        = list(string)
  description = "List of CIDRs for private subnets"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to assign"
}
