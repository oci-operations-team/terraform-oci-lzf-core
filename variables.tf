# Copyright (c) 2022 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

variable "tenancy_id" {}
variable "user_id" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "private_key_password" {}
variable "home_region" {}

#-------------------------------------------------------------
#-- Arbitrary compartments topology
#-------------------------------------------------------------
variable "compartments" {
  description = "The compartments structure, given as a map of objects nested up to 6 levels."
  type = map(object({
    name          = string
    description   = string
    parent_id     = string
    defined_tags  = map(string)
    freeform_tags = map(string)
    children = map(object({
      name          = string
      description   = string
      defined_tags  = map(string)
      freeform_tags = map(string)
      children = map(object({
        name          = string
        description   = string
        defined_tags  = map(string)
        freeform_tags = map(string)
        children = map(object({
          name          = string
          description   = string
          defined_tags  = map(string)
          freeform_tags = map(string)
          children = map(object({
            name          = string
            description   = string
            defined_tags  = map(string)
            freeform_tags = map(string)
            children = map(object({
              name          = string
              description   = string
              defined_tags  = map(string)
              freeform_tags = map(string)
            }))
          }))
        }))
      }))
    }))
  }))
  default = {}
}

variable "enable_compartments_delete" {
  description = "Whether compartments are physically deleted upon destroy."
  type        = bool
  default     = true
}

variable "network_configuration" {
  type = object({
    default_compartment_id   = string,
    default_compartment_key = string,
    default_defined_tags     = map(string),
    default_freeform_tags    = map(string),


    network_configuration_categories = map(object({
      category_compartment_id   = string,
      category_compartment_key = string,
      category_defined_tags     = map(string),
      category_freeform_tags    = map(string),

      vcns = map(object({
        compartment_id   = string,
        compartment_key = string,
        display_name     = string
        byoipv6cidr_details = map(object({
          byoipv6range_id = string
          ipv6cidr_block  = string
        }))
        ipv6private_cidr_blocks          = list(string),
        is_ipv6enabled                   = bool,
        is_oracle_gua_allocation_enabled = bool,
        cidr_blocks                      = list(string),
        dns_label                        = string,
        is_create_igw                    = bool,
        is_attach_drg                    = bool,
        block_nat_traffic                = bool,
        defined_tags                     = map(string),
        freeform_tags                    = map(string),

        security_lists = map(object({
          compartment_id   = string,
          compartment_key = string,
          defined_tags     = map(string),
          freeform_tags    = map(string),
          display_name     = string,
          ingress_rules = list(object({
            stateless    = bool,
            protocol     = string,
            description  = string,
            src          = string,
            src_type     = string,
            src_port_min = number,
            src_port_max = number,
            dst_port_min = number,
            dst_port_max = number,
            icmp_type    = number,
            icmp_code    = number
          })),
          egress_rules = list(object({
            stateless    = bool,
            protocol     = string,
            description  = string,
            dst          = string,
            dst_type     = string,
            src_port_min = number,
            src_port_max = number,
            dst_port_min = number,
            dst_port_max = number,
            icmp_type    = number,
            icmp_code    = number
          }))
        }))

        route_tables = map(object({
          compartment_id   = string,
          compartment_key = string,
          defined_tags     = map(string),
          freeform_tags    = map(string),
          display_name     = string,
          route_rules = map(object({
            network_entity_name = string,
            description         = string,
            destination         = string,
            destination_type    = string
          }))
        }))

        dhcp_options = map(object({
          compartment_id   = string,
          compartment_key = string,
          display_name     = string,
          defined_tags     = map(string),
          freeform_tags    = map(string),
          domain_name_type = string,
          options = map(object({
            type                = string,
            server_type         = string,
            custom_dns_servers  = list(string)
            search_domain_names = list(string)
          }))
        }))

        subnets = map(object({
          cidr_block       = string,
          compartment_id   = string,
          compartment_key = string,
          #Optional
          availability_domain        = string,
          defined_tags               = map(string),
          dhcp_options_name          = string,
          display_name               = string,
          dns_label                  = string,
          freeform_tags              = map(string),
          ipv6cidr_block             = string,
          ipv6cidr_blocks            = list(string),
          prohibit_internet_ingress  = bool,
          prohibit_public_ip_on_vnic = bool,
          route_table_name           = string,
          security_list_names        = list(string)
        }))

        network_security_groups = map(object({
          compartment_id   = string,
          compartment_key = string,
          defined_tags     = map(string)
          freeform_tags    = map(string)
          ingress_rules = map(object({
            description  = string,
            protocol     = string,
            stateless    = bool,
            src          = string,
            src_type     = string,
            dst_port_min = number,
            dst_port_max = number,
            src_port_min = number,
            src_port_max = number,
            icmp_type    = number,
            icmp_code    = number
          })),
          egress_rules = map(object({
            description  = string,
            protocol     = string,
            stateless    = bool,
            dst          = string,
            dst_type     = string,
            dst_port_min = number,
            dst_port_max = number,
            src_port_min = number,
            src_port_max = number,
            icmp_type    = number,
            icmp_code    = number
          }))
        }))

        vcn_specific_gateways = object({
          internet_gateways = map(object({
            compartment_id   = string,
            compartment_key = string,
            enabled          = bool,
            defined_tags     = map(string),
            display_name     = string,
            freeform_tags    = map(string),
            route_table_name = string
          }))

          nat_gateways = map(object({
            compartment_id   = string,
            compartment_key = string,
            block_traffic    = bool,
            defined_tags     = map(string),
            display_name     = string,
            freeform_tags    = map(string),
            public_ip_id     = string,
            route_table_name = string
          }))

          service_gateways = map(object({
            compartment_id   = string,
            compartment_key = string,
            defined_tags     = map(string),
            display_name     = string,
            freeform_tags    = map(string),
            route_table_name = string
          }))

          local_peering_gateways = map(object({
            compartment_id   = string,
            compartment_key = string,
            defined_tags     = map(string),
            display_name     = string,
            freeform_tags    = map(string),
            peer_id          = string,
            peer_name        = string,
            route_table_name = string
          }))
        })
      }))

      inject_into_existing_vcns = map(object({

        vcn_id = string,

        security_lists = map(object({
          compartment_id   = string,
          compartment_key = string,
          defined_tags     = map(string),
          freeform_tags    = map(string),
          display_name     = string,
          ingress_rules = list(object({
            stateless    = bool,
            protocol     = string,
            description  = string,
            src          = string,
            src_type     = string,
            src_port_min = number,
            src_port_max = number,
            dst_port_min = number,
            dst_port_max = number,
            icmp_type    = number,
            icmp_code    = number
          })),
          egress_rules = list(object({
            stateless    = bool,
            protocol     = string,
            description  = string,
            dst          = string,
            dst_type     = string,
            src_port_min = number,
            src_port_max = number,
            dst_port_min = number,
            dst_port_max = number,
            icmp_type    = number,
            icmp_code    = number
          }))
        }))

        route_tables = map(object({
          compartment_id   = string,
          compartment_key = string,
          defined_tags     = map(string),
          freeform_tags    = map(string),
          display_name     = string,
          route_rules = map(object({
            network_entity_id   = string,
            network_entity_name = string,
            description         = string,
            destination         = string,
            destination_type    = string
          }))
        }))

        dhcp_options = map(object({
          compartment_id   = string,
          compartment_key = string,
          display_name     = string,
          defined_tags     = map(string),
          freeform_tags    = map(string),
          domain_name_type = string,
          options = map(object({
            type                = string,
            server_type         = string,
            custom_dns_servers  = list(string)
            search_domain_names = list(string)
          }))
        }))

        subnets = map(object({
          cidr_block       = string,
          compartment_id   = string,
          compartment_key = string,
          #Optional
          availability_domain        = string,
          defined_tags               = map(string),
          dhcp_options_id            = string,
          dhcp_options_name          = string,
          display_name               = string,
          dns_label                  = string,
          freeform_tags              = map(string),
          ipv6cidr_block             = string,
          ipv6cidr_blocks            = list(string),
          prohibit_internet_ingress  = bool,
          prohibit_public_ip_on_vnic = bool,
          route_table_id             = string,
          route_table_name           = string,
          security_list_ids          = list(string),
          security_list_names        = list(string)
        }))

        network_security_groups = map(object({
          compartment_id   = string,
          compartment_key = string,
          defined_tags     = map(string)
          freeform_tags    = map(string)
          ingress_rules = map(object({
            description  = string,
            protocol     = string,
            stateless    = bool,
            src          = string,
            src_type     = string,
            dst_port_min = number,
            dst_port_max = number,
            src_port_min = number,
            src_port_max = number,
            icmp_type    = number,
            icmp_code    = number
          })),
          egress_rules = map(object({
            description  = string,
            protocol     = string,
            stateless    = bool,
            dst          = string,
            dst_type     = string,
            dst_port_min = number,
            dst_port_max = number,
            src_port_min = number,
            src_port_max = number,
            icmp_type    = number,
            icmp_code    = number
          }))
        }))

        vcn_specific_gateways = object({
          internet_gateways = map(object({
            compartment_id   = string,
            compartment_key = string,
            enabled          = bool,
            defined_tags     = map(string),
            display_name     = string,
            freeform_tags    = map(string),
            route_table_id   = string,
            route_table_name = string
          }))

          nat_gateways = map(object({
            compartment_id   = string,
            compartment_key = string,
            block_traffic    = bool,
            defined_tags     = map(string),
            display_name     = string,
            freeform_tags    = map(string),
            public_ip_id     = string,
            route_table_id   = string,
            route_table_name = string
          }))

          service_gateways = map(object({
            compartment_id   = string,
            compartment_key = string,
            defined_tags     = map(string),
            display_name     = string,
            freeform_tags    = map(string),
            route_table_id   = string,
            route_table_name = string
          }))

          local_peering_gateways = map(object({
            compartment_id   = string,
            compartment_key = string,
            defined_tags     = map(string),
            display_name     = string,
            freeform_tags    = map(string),
            peer_id          = string,
            peer_name        = string,
            route_table_id   = string,
            route_table_name = string
          }))
        })
      }))

      non_vcn_specific_gateways = object({

        dynamic_routing_gateways = map(object({
          compartment_id   = string,
          compartment_key = string,
          defined_tags     = map(string),
          display_name     = string,
          freeform_tags    = map(string),

          remote_peering_connections = map(object({
            compartment_id   = string,
            compartment_key = string,
            defined_tags     = map(string),
            display_name     = string,
            freeform_tags    = map(string),
            peer_id          = string,
            peer_name        = string,
            peer_region_name = string
          }))

          drg_attachments = map(object({
            defined_tags         = map(string),
            display_name         = string,
            freeform_tags        = map(string),
            drg_route_table_id   = string,
            drg_route_table_name = string,
            network_details = object({
              attached_resource_id   = string,
              attached_resource_name = string,
              type                   = string,
              route_table_id         = string,
              route_table_name       = string,
              vcn_route_type         = string
            })
          }))
          drg_route_tables = map(object({
            defined_tags                     = map(string),
            display_name                     = string,
            freeform_tags                    = map(string),
            import_drg_route_distribution_id = string,
            is_ecmp_enabled                  = bool
          }))

          drg_route_distributions = map(object({
            distribution_type = string,
            defined_tags      = map(string),
            display_name      = string,
            freeform_tags     = map(string),
            statements = map(object({
              action = string,
              match_criteria = map(object({
                match_type        = string,
                attachment_type   = string,
                drg_attachment_id = string,
              }))
              priority = number
            }))
          }))
        }))
      })
    }))
  })
}