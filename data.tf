data "oci_container_instances_container_instances" "existing_resource" {

    compartment_id = var.container_instance.compartment_ocid
    display_name = var.container_instance.display_name
}
