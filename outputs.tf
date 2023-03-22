# Copyright (c) 2022 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

locals {
  compartments = merge(
    module.cislz_compartments.level_1_compartments,
    module.cislz_compartments.level_2_compartments,
    module.cislz_compartments.level_3_compartments,
    module.cislz_compartments.level_4_compartments,
    module.cislz_compartments.level_5_compartments,
    module.cislz_compartments.level_6_compartments
  )
}
/*
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
*/
output "provisioned_networking_resources" {
  description = "Provisioned networking resources"
  value       = module.terraform-oci-cis-landing-zone-network.provisioned_networking_resources
}

output "cmp_name_to_cislz_tag_map" {
  value = module.cislz_policies.map_of_compartments_tagged_with_cislz_tag_lookup_value
}

output "cmp_type_list" {
  value = module.cislz_policies.list_of_compartments_types_tagged_with_cislz_tag_lookup_value
}

/*
output "input_locals" {
  value = local.network_configuration
}
*/