package terraform.policies.tags

import input as tfplan

default allow := false

allow := true if {
  not deny
}

deny := msg if {
  msg := resources_with_no_tags
}

resources_with_no_tags := [ resource |
  r := tfplan.resource_changes[_]
  not has_not_tags(r)
    resource := sprintf("%s resource must contain tags", [r.address])
]

has_not_tags(resource) := true if {
  r_tags := is_null(resource.change.after.tags[_])
}