data "oci_container_instances_container_instance" "existing_resource" {
    for_each = {
        for k, v in local.helper_resource_map : k => v
        if v.container_instance_id != null
    }
    container_instance_id = each.value.container_instance_id
}
