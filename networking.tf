# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

module "terraform-oci-cis-landing-zone-network" {
  source                = "git@github.com:oci-operations-team/terraform-oci-networking.git?ref=v0.1.7"
  network_configuration = null
}