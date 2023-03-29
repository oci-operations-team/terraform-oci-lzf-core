# Copyright (c) 2022 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

locals {
  compartments = module.cislz_compartments.compartments
}

output "compartments" {
  value = local.compartments
}

output "groups" {
  description = "The groups."
  value       = module.cislz_groups.groups
}

output "memberships" {
  description = "The memberships."
  value       = module.cislz_groups.memberships
}

output "provisioned_networking_resources" {
  description = "Provisioned networking resources"
  value       = module.terraform-oci-cis-landing-zone-network.provisioned_networking_resources
}

output "map_of_compartments_tagged_with_cislz_tag_lookup_value" {
  value = module.cislz_policies.map_of_compartments_tagged_with_cislz_tag_lookup_value
}

output "list_of_compartments_types_tagged_with_cislz_tag_lookup_value" {
  value = module.cislz_policies.list_of_compartments_types_tagged_with_cislz_tag_lookup_value
}

output "policies" {
  value = module.cislz_policies.policies
}

/*
output "input_locals" {
  value = local.network_configuration
}
*/