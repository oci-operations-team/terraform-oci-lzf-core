# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

module "cislz_compartments" {
  source                     = "git@github.com:oci-operations-team/terraform-oci-cis-landing-zone-compartments.git?ref=v0.0.1"
  compartments               = var.compartments
  enable_compartments_delete = var.enable_compartments_delete
}