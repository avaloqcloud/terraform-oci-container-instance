resource "oci_container_instances_container_instance" "this" {
  compartment_id      = var.compartment_ocid
  display_name        = var.container_name
  availability_domain = var.ad
  shape               = "CI.Standard.E4.Flex"
  shape_config {
    ocpus = var.shape_config_ocpus
  }
  vnics {
    subnet_id = oci_core_subnet.test_subnet.id
  }
  containers {
    display_name          = var.container_name
    image_url             = var.container_image_url
    environment_variables = var.env_variables
  }
}

resource "oci_core_internet_gateway" "test_igw" {

  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.test_vcn.id
  display_name   = "test-vcn - Internet gateway"
  enabled        = true
}

resource "oci_core_vcn" "test_vcn" {
  cidr_blocks    = ["10.0.0.0/16"]
  compartment_id = var.compartment_ocid
  dns_label      = "TestDNS"
}

resource "oci_core_subnet" "test_subnet" {
  cidr_block     = "10.0.0.0/24"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.test_vcn.id
  dns_label      = "TestSubnet"
  route_table_id = oci_core_route_table.test_igw_rt.id
}


resource "oci_core_route_table" "test_igw_rt" {

  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.test_vcn.id
  display_name   = "test-vcn - Internet gateway route table"
  route_rules {

    network_entity_id = oci_core_internet_gateway.test_igw.id
    destination       = "0.0.0.0/0"
  }
}
