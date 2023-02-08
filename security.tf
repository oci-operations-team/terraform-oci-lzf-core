# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

locals {
  policies = {
    enable_compartment_level_template_policies = var.policies.enable_compartment_level_template_policies
    target_compartments = [
      for cmp_key, cmp_value in local.compartments : {
        name          = cmp_value.name
        id            = cmp_value.id
        freeform_tags = cmp_value.freeform_tags
    }]
    cislz_tag_lookup_value                 = var.policies.cislz_tag_lookup_value
    enable_tenancy_level_template_policies = var.policies.enable_tenancy_level_template_policies
    groups_with_tenancy_level_roles        = var.policies.groups_with_tenancy_level_roles
    custom_policies                        = var.policies.custom_policies
    enable_cis_benchmark_checks            = var.policies.enable_cis_benchmark_checks
    defined_tags                           = var.policies.defined_tags
    freeform_tags                          = var.policies.freeform_tags
    policy_name_prefix                     = var.policies.policy_name_prefix
    enable_output                          = var.policies.enable_output
    enable_debug                           = var.policies.enable_debug
  }
}


module "cislz_compartments" {
  source                     = "git@github.com:oci-operations-team/terraform-oci-cis-landing-zone-compartments.git?ref=v0.0.1"
  compartments               = var.compartments
  enable_compartments_delete = var.enable_compartments_delete
}

module "cislz_groups" {
  source     = "git@github.com:oci-operations-team/terraform-oci-cis-landing-zone-groups.git?ref=v0.0.1"
  tenancy_id = var.tenancy_id
  groups     = var.groups
}

module "cislz_policies" {
  source                                     = "git@github.com:oci-operations-team/terraform-oci-cis-landing-zone-policies.git?ref=v0.0.1"
  tenancy_id                                 = var.tenancy_id
  enable_compartment_level_template_policies = local.policies.enable_compartment_level_template_policies
  target_compartments                        = local.policies.target_compartments
  cislz_tag_lookup_value                     = local.policies.cislz_tag_lookup_value
  enable_tenancy_level_template_policies     = local.policies.enable_tenancy_level_template_policies
  groups_with_tenancy_level_roles            = local.policies.groups_with_tenancy_level_roles
  custom_policies                            = local.policies.custom_policies
  enable_cis_benchmark_checks                = local.policies.enable_cis_benchmark_checks
  defined_tags                               = local.policies.defined_tags
  freeform_tags                              = local.policies.freeform_tags
  policy_name_prefix                         = local.policies.policy_name_prefix
  enable_output                              = local.policies.enable_output
  enable_debug                               = local.policies.enable_debug
}
