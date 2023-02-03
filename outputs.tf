# Copyright (c) 2022 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

output "compartments" {
  value = merge(
    module.cislz_compartments.level_1_compartments,
    module.cislz_compartments.level_2_compartments,
    module.cislz_compartments.level_3_compartments,
    module.cislz_compartments.level_4_compartments,
    module.cislz_compartments.level_5_compartments,
    module.cislz_compartments.level_6_compartments
  )
}

output "networking_configuration" {
  value = merge(
    module.terraform-oci-cis-landing-zone-network.provisioned_vcns,
    module.terraform-oci-cis-landing-zone-network.provisioned_subnets,
    module.terraform-oci-cis-landing-zone-network.provisioned_security_lists,
    module.terraform-oci-cis-landing-zone-network.provisioned_network_security_groups,
    module.terraform-oci-cis-landing-zone-network.provisioned_network_security_groups_ingress_rules,
    module.terraform-oci-cis-landing-zone-network.provisioned_network_security_groups_egress_rules,
    module.terraform-oci-cis-landing-zone-network.provisioned_route_tables_attachments,
    module.terraform-oci-cis-landing-zone-network.provisioned_route_tables,
    module.terraform-oci-cis-landing-zone-network.provisioned_dhcp_options,
    module.terraform-oci-cis-landing-zone-network.provisioned_internet_gateways,
    module.terraform-oci-cis-landing-zone-network.provisioned_nat_gateways,
    module.terraform-oci-cis-landing-zone-network.provisioned_service_gateways,
    module.terraform-oci-cis-landing-zone-network.provisioned_local_peering_gateways,
    module.terraform-oci-cis-landing-zone-network.provisioned_dynamic_gateways,
    module.terraform-oci-cis-landing-zone-network.provisioned_remote_peering_connections,
    module.terraform-oci-cis-landing-zone-network.provisioned_drg_attachments,
    module.terraform-oci-cis-landing-zone-network.provisioned_drg_route_tables,
    module.terraform-oci-cis-landing-zone-network.provisioned_drg_route_distributions,
    module.terraform-oci-cis-landing-zone-network.provisioned_drg_route_distributions_statements
  )
}