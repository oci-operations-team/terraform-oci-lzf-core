# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

locals {
  network_configuration = {
    default_compartment_id = var.network_configuration.default_compartment_id != null ? var.network_configuration.default_compartment_id : var.network_configuration.default_compartment_key != null ? local.compartments[var.network_configuration.default_compartment_key].id : null
    default_defined_tags   = var.network_configuration.default_defined_tags
    default_freeform_tags  = var.network_configuration.default_freeform_tags
    network_configuration_categories = var.network_configuration.network_configuration_categories != null ? length(var.network_configuration.network_configuration_categories) > 0 ? {
      for netconfig_key, netconfig_value in var.network_configuration.network_configuration_categories : netconfig_key => {
        category_compartment_id = netconfig_value.category_compartment_id != null ? netconfig_value.category_compartment_id : netconfig_value.category_compartment_key != null ? local.compartments[netconfig_value.category_compartment_key].id : null
        category_defined_tags   = netconfig_value.category_defined_tags
        category_freeform_tags  = netconfig_value.category_freeform_tags
        vcns = netconfig_value.vcns != null ? length(netconfig_value.vcns) > 0 ? {
          for vcn_key, vcn_value in netconfig_value.vcns : vcn_key => {
            compartment_id                   = vcn_value.compartment_id != null ? vcn_value.compartment_id : vcn_value.compartment_key != null ? local.compartments[vcn_value.compartment_key].id : null
            display_name                     = vcn_value.display_name
            byoipv6cidr_details              = vcn_value.byoipv6cidr_details
            ipv6private_cidr_blocks          = vcn_value.ipv6private_cidr_blocks
            is_ipv6enabled                   = vcn_value.is_ipv6enabled
            is_oracle_gua_allocation_enabled = vcn_value.is_oracle_gua_allocation_enabled
            cidr_blocks                      = vcn_value.cidr_blocks
            dns_label                        = vcn_value.dns_label
            is_create_igw                    = vcn_value.is_create_igw
            is_attach_drg                    = vcn_value.is_attach_drg
            block_nat_traffic                = vcn_value.block_nat_traffic
            defined_tags                     = vcn_value.defined_tags
            freeform_tags                    = vcn_value.freeform_tags
            security_lists = vcn_value.security_lists != null ? length(vcn_value.security_lists) > 0 ? {
              for seclist_key, seclist_value in vcn_value.security_lists : seclist_key => {
                compartment_id = seclist_value.compartment_id != null ? seclist_value.compartment_id : seclist_value.compartment_key != null ? local.compartments[seclist_value.compartment_key].id : null
                defined_tags   = seclist_value.defined_tags
                freeform_tags  = seclist_value.freeform_tags
                display_name   = seclist_value.display_name
                ingress_rules  = seclist_value.ingress_rules
                egress_rules   = seclist_value.egress_rules
              }
            } : {} : {}
            route_tables = vcn_value.route_tables != null ? length(vcn_value.route_tables) > 0 ? {
              for rt_key, rt_value in vcn_value.route_tables : rt_key => {
                compartment_id = rt_value.compartment_id != null ? rt_value.compartment_id : rt_value.compartment_key != null ? local.compartments[rt_value.compartment_key].id : null
                defined_tags   = rt_value.defined_tags
                freeform_tags  = rt_value.freeform_tags
                display_name   = rt_value.display_name
                route_rules    = rt_value.route_rules
              }
            } : {} : {}
            dhcp_options = vcn_value.dhcp_options != null ? length(vcn_value.dhcp_options) > 0 ? {
              for dhcpo_key, dhcpo_value in vcn_value.dhcp_options : dhcpo_key => {
                compartment_id   = dhcpo_value.compartment_id != null ? dhcpo_value.compartment_id : dhcpo_value.compartment_key != null ? local.compartments[dhcpo_value.compartment_key].id : null
                defined_tags     = dhcpo_value.defined_tags
                freeform_tags    = dhcpo_value.freeform_tags
                display_name     = dhcpo_value.display_name
                domain_name_type = dhcpo_value.domain_name_type
                options          = dhcpo_value.options
              }
            } : {} : {}
            subnets = vcn_value.subnets != null ? length(vcn_value.subnets) > 0 ? {
              for subn_key, subn_value in vcn_value.subnets : subn_key => {
                compartment_id             = subn_value.compartment_id != null ? subn_value.compartment_id : subn_value.compartment_key != null ? local.compartments[subn_value.compartment_key].id : null
                cidr_block                 = subn_value.cidr_block
                availability_domain        = subn_value.availability_domain
                defined_tags               = subn_value.defined_tags
                dhcp_options_name          = subn_value.dhcp_options_name
                freeform_tags              = subn_value.freeform_tags
                display_name               = subn_value.display_name
                dns_label                  = subn_value.dns_label
                freeform_tags              = subn_value.freeform_tags
                ipv6cidr_block             = subn_value.ipv6cidr_block
                ipv6cidr_blocks            = subn_value.ipv6cidr_blocks
                prohibit_internet_ingress  = subn_value.prohibit_internet_ingress
                prohibit_public_ip_on_vnic = subn_value.prohibit_public_ip_on_vnic
                route_table_name           = subn_value.route_table_name
                security_list_names        = subn_value.security_list_names
              }
            } : {} : {}
            network_security_groups = vcn_value.network_security_groups != null ? length(vcn_value.network_security_groups) > 0 ? {
              for nsg_key, nsg_value in vcn_value.network_security_groups : nsg_key => {
                compartment_id = nsg_value.compartment_id != null ? nsg_value.compartment_id : nsg_value.compartment_key != null ? local.compartments[nsg_value.compartment_key].id : null
                defined_tags   = nsg_value.defined_tags
                freeform_tags  = nsg_value.freeform_tags
                ingress_rules  = nsg_value.ingress_rules
                egress_rules   = nsg_value.egress_rules
              }
            } : {} : {}
            vcn_specific_gateways = {
              internet_gateways = vcn_value.vcn_specific_gateways.internet_gateways != null ? length(vcn_value.vcn_specific_gateways.internet_gateways) > 0 ? {
                for ig_key, ig_value in vcn_value.vcn_specific_gateways.internet_gateways : ig_key => {
                  compartment_id   = ig_value.compartment_id != null ? ig_value.compartment_id : ig_value.compartment_key != null ? local.compartments[ig_value.compartment_key].id : null
                  enabled          = ig_value.enabled
                  defined_tags     = ig_value.defined_tags
                  display_name     = ig_value.display_name
                  freeform_tags    = ig_value.freeform_tags
                  route_table_name = ig_value.route_table_name
                }
              } : {} : {}
              nat_gateways = vcn_value.vcn_specific_gateways.nat_gateways != null ? length(vcn_value.vcn_specific_gateways.nat_gateways) > 0 ? {
                for natg_key, natg_value in vcn_value.vcn_specific_gateways.nat_gateways : natg_key => {
                  compartment_id   = natg_value.compartment_id != null ? natg_value.compartment_id : natg_value.compartment_key != null ? local.compartments[natg_value.compartment_key].id : null
                  block_traffic    = natg_value.block_traffic
                  defined_tags     = natg_value.defined_tags
                  display_name     = natg_value.display_name
                  freeform_tags    = natg_value.freeform_tags
                  public_ip_id     = natg_value.public_ip_id
                  route_table_name = natg_value.route_table_name
                }
              } : {} : {}
              service_gateways = vcn_value.vcn_specific_gateways.service_gateways != null ? length(vcn_value.vcn_specific_gateways.service_gateways) > 0 ? {
                for svcg_key, svcg_value in vcn_value.vcn_specific_gateways.service_gateways : svcg_key => {
                  compartment_id   = svcg_value.compartment_id != null ? svcg_value.compartment_id : svcg_value.compartment_key != null ? local.compartments[svcg_value.compartment_key].id : null
                  defined_tags     = svcg_value.defined_tags
                  display_name     = svcg_value.display_name
                  freeform_tags    = svcg_value.freeform_tags
                  route_table_name = svcg_value.route_table_name

                }
              } : {} : {}
              local_peering_gateways = vcn_value.vcn_specific_gateways.local_peering_gateways != null ? length(vcn_value.vcn_specific_gateways.local_peering_gateways) > 0 ? {
                for lpg_key, lpg_value in vcn_value.vcn_specific_gateways.local_peering_gateways : lpg_key => {
                  compartment_id   = lpg_value.compartment_id != null ? lpg_value.compartment_id : lpg_value.compartment_key != null ? local.compartments[lpg_value.compartment_key].id : null
                  defined_tags     = lpg_value.defined_tags
                  display_name     = lpg_value.display_name
                  freeform_tags    = lpg_value.freeform_tags
                  peer_id          = lpg_value.peer_id
                  peer_name        = lpg_value.peer_name
                  route_table_name = lpg_value.route_table_name
                }
              } : {} : {}
            }
          }
        } : {} : {}
        inject_into_existing_vcns = netconfig_value.inject_into_existing_vcns != null ? length(netconfig_value.inject_into_existing_vcns) > 0 ? {
          for vcn_key, vcn_value in netconfig_value.inject_into_existing_vcns : vcn_key => {
            vcn_id = vcn_value.vcn_id
            security_lists = vcn_value.security_lists != null ? length(vcn_value.security_lists) > 0 ? {
              for seclist_key, seclist_value in vcn_value.security_lists : seclist_key => {
                compartment_id = seclist_value.compartment_id != null ? seclist_value.compartment_id : seclist_value.compartment_key != null ? local.compartments[seclist_value.compartment_key].id : null
                defined_tags   = seclist_value.defined_tags
                freeform_tags  = seclist_value.freeform_tags
                display_name   = seclist_value.display_name
                ingress_rules  = seclist_value.ingress_rules
                egress_rules   = seclist_value.egress_rules
              }
            } : {} : {}
            route_tables = vcn_value.route_tables != null ? length(vcn_value.route_tables) > 0 ? {
              for rt_key, rt_value in vcn_value.route_tables : rt_key => {
                compartment_id = rt_value.compartment_id != null ? rt_value.compartment_id : rt_value.compartment_key != null ? local.compartments[rt_value.compartment_key].id : null
                defined_tags   = rt_value.defined_tags
                freeform_tags  = rt_value.freeform_tags
                display_name   = rt_value.display_name
                route_rules    = rt_value.route_rules
              }
            } : {} : {}
            dhcp_options = vcn_value.dhcp_options != null ? length(vcn_value.dhcp_options) > 0 ? {
              for dhcpo_key, dhcpo_value in vcn_value.dhcp_options : dhcpo_key => {
                compartment_id   = dhcpo_value.compartment_id != null ? dhcpo_value.compartment_id : dhcpo_value.compartment_key != null ? local.compartments[dhcpo_value.compartment_key].id : null
                defined_tags     = dhcpo_value.defined_tags
                freeform_tags    = dhcpo_value.freeform_tags
                display_name     = dhcpo_value.display_name
                domain_name_type = dhcpo_value.domain_name_type
                options          = dhcpo_value.options
              }
            } : {} : {}
            subnets = vcn_value.subnets != null ? length(vcn_value.subnets) > 0 ? {
              for subn_key, subn_value in vcn_value.subnets : subn_key => {
                compartment_id             = subn_value.compartment_id != null ? subn_value.compartment_id : subn_value.compartment_key != null ? local.compartments[subn_value.compartment_key].id : null
                cidr_block                 = subn_value.cidr_block
                availability_domain        = subn_value.availability_domain
                defined_tags               = subn_value.defined_tags
                dhcp_options_id            = subn_value.dhcp_options_id
                dhcp_options_name          = subn_value.dhcp_options_name
                freeform_tags              = subn_value.freeform_tags
                display_name               = subn_value.display_name
                dns_label                  = subn_value.dns_label
                freeform_tags              = subn_value.freeform_tags
                ipv6cidr_block             = subn_value.ipv6cidr_block
                ipv6cidr_blocks            = subn_value.ipv6cidr_blocks
                prohibit_internet_ingress  = subn_value.prohibit_internet_ingress
                prohibit_public_ip_on_vnic = subn_value.prohibit_public_ip_on_vnic
                route_table_id             = subn_value.route_table_name
                route_table_name           = subn_value.route_table_name
                security_list_names        = subn_value.security_list_names
                security_list_ids          = subn_value.security_list_ids
              }
            } : {} : {}
            network_security_groups = vcn_value.network_security_groups != null ? length(vcn_value.network_security_groups) > 0 ? {
              for nsg_key, nsg_value in vcn_value.network_security_groups : nsg_key => {
                compartment_id = nsg_value.compartment_id != null ? nsg_value.compartment_id : nsg_value.compartment_key != null ? local.compartments[nsg_value.compartment_key].id : null
                defined_tags   = nsg_value.defined_tags
                freeform_tags  = nsg_value.freeform_tags
                ingress_rules  = nsg_value.ingress_rules
                egress_rules   = nsg_value.egress_rules
              }
            } : {} : {}
            vcn_specific_gateways = vcn_value.vcn_specific_gateways != null ? {
              internet_gateways = vcn_value.vcn_specific_gateways.internet_gateways != null ? length(vcn_value.vcn_specific_gateways.internet_gateways) > 0 ? {
                for ig_key, ig_value in vcn_value.vcn_specific_gateways.internet_gateways : ig_key => {
                  compartment_id   = ig_value.compartment_id != null ? ig_value.compartment_id : ig_value.compartment_key != null ? local.compartments[ig_value.compartment_key].id : null
                  enabled          = ig_value.enabled
                  defined_tags     = ig_value.defined_tags
                  display_name     = ig_value.display_name
                  freeform_tags    = ig_value.freeform_tags
                  route_table_id   = ig_value.route_table_id
                  route_table_name = ig_value.route_table_name
                }
              } : {} : {}
              nat_gateways = vcn_value.vcn_specific_gateways.nat_gateways != null ? length(vcn_value.vcn_specific_gateways.nat_gateways) > 0 ? {
                for natg_key, natg_value in vcn_value.vcn_specific_gateways.nat_gateways : natg_key => {
                  compartment_id   = natg_value.compartment_id != null ? natg_value.compartment_id : natg_value.compartment_key != null ? local.compartments[natg_value.compartment_key].id : null
                  block_traffic    = natg_value.block_traffic
                  defined_tags     = natg_value.defined_tags
                  display_name     = natg_value.display_name
                  freeform_tags    = natg_value.freeform_tags
                  public_ip_id     = natg_value.public_ip_id
                  route_table_id   = natg_value.route_table_id
                  route_table_name = natg_value.route_table_name
                }
              } : {} : {}
              service_gateways = vcn_value.vcn_specific_gateways.service_gateways != null ? length(vcn_value.vcn_specific_gateways.service_gateways) > 0 ? {
                for svcg_key, svcg_value in vcn_value.vcn_specific_gateways.service_gateways : svcg_key => {
                  compartment_id   = svcg_value.compartment_id != null ? svcg_value.compartment_id : svcg_value.compartment_key != null ? local.compartments[svcg_value.compartment_key].id : null
                  defined_tags     = svcg_value.defined_tags
                  display_name     = svcg_value.display_name
                  freeform_tags    = svcg_value.freeform_tags
                  route_table_name = svcg_value.route_table_name
                  route_table_id   = svcg_value.route_table_id

                }
              } : {} : {}
              local_peering_gateways = vcn_value.vcn_specific_gateways.local_peering_gateways != null ? length(vcn_value.vcn_specific_gateways.local_peering_gateways) > 0 ? {
                for lpg_key, lpg_value in vcn_value.vcn_specific_gateways.local_peering_gateways : lpg_key => {
                  compartment_id   = lpg_value.compartment_id != null ? lpg_value.compartment_id : lpg_value.compartment_key != null ? local.compartments[lpg_value.compartment_key].id : null
                  defined_tags     = lpg_value.defined_tags
                  display_name     = lpg_value.display_name
                  freeform_tags    = lpg_value.freeform_tags
                  peer_id          = lpg_value.peer_id
                  peer_name        = lpg_value.peer_name
                  route_table_name = lpg_value.route_table_name
                  route_table_id   = lpg_value.route_table_id
                }
              } : {} : {}
            } : null
          }
        } : {} : {}
        non_vcn_specific_gateways = netconfig_value.non_vcn_specific_gateways != null ? {
          dynamic_routing_gateways = netconfig_value.non_vcn_specific_gateways.dynamic_routing_gateways != null ? length(netconfig_value.non_vcn_specific_gateways.dynamic_routing_gateways) > 0 ? {
            for drg_key, drg_value in netconfig_value.non_vcn_specific_gateways.dynamic_routing_gateways : drg_key => {
              compartment_id = drg_value.compartment_id != null ? drg_value.compartment_id : drg_value.compartment_key != null ? local.compartments[drg_value.compartment_key].id : null
              defined_tags   = drg_value.defined_tags
              display_name   = drg_value.display_name
              freeform_tags  = drg_value.freeform_tags
              remote_peering_connections = drg_value.remote_peering_connections != null ? length(drg_value.remote_peering_connections) > 0 ? {
                for rpc_key, rpc_value in drg_value.remote_peering_connections : rpc_key => {
                  compartment_id   = rpc_value.compartment_id != null ? rpc_value.compartment_id : rpc_value.compartment_key != null ? local.compartments[rpc_value.compartment_key].id : null
                  defined_tags     = rpc_value.defined_tags
                  display_name     = rpc_value.display_name
                  freeform_tags    = rpc_value.freeform_tags
                  peer_id          = rpc_value.peer_id
                  peer_name        = rpc_value.peer_name
                  peer_region_name = rpc_value.peer_region_name
                }
              } : {} : {}
              drg_attachments         = drg_value.drg_attachments
              drg_route_tables        = drg_value.drg_route_tables
              drg_route_distributions = drg_value.drg_route_distributions
            }
          } : {} : {}
        } : null
      }
    } : null : null
  }
}

module "terraform-oci-cis-landing-zone-network" {
  source                = "git@github.com:oci-operations-team/terraform-oci-cis-landing-zone-network.git?ref=v0.1.7"
  network_configuration = local.network_configuration
}