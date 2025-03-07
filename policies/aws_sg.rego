package terraform.policies.sg

import input as tfplan

default allow := false

allow := true if {
  not deny
}

# Deny creation/edition of security groups that had ingress of 0.0.0.0/0
deny := msg if {
  r := tfplan.resource_changes[_]
  r.type == "aws_security_group"
  i := r.change.after.ingress[_].cidr_blocks[_]
  r.change.after.ingress[_].cidr_blocks[_] == "0.0.0.0/0"
  msg := sprintf("%v has 0.0.0.0/0 is not allowed to be used as ingress", [r.address])
}