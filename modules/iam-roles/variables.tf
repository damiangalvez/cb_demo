variable "role_name" {
  type        = string
  description = "Name of the IAM role to create"
}

variable "assume_role_policy" {
  type        = string
  description = "JSON for the assume role policy"
}

variable "policy_name" {
  type        = string
  description = "Name of the custom policy"
}

variable "policy_document" {
  type        = string
  description = "JSON for the IAM policy document"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags"
}
