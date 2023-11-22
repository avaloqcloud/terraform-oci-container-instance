resource "oci_container_instances_container_instance" "this" {
    for_each = local.potential_resource
    availability_domain      = each.value.availability_domain
    compartment_id           = each.value.compartment_ocid

    display_name             = "${each.value.display_name}-container-instance"
    container_restart_policy = each.value.container_restart_policy
    shape                    = each.value.shape

    shape_config {
        memory_in_gbs = each.value.memory_in_gbs
        ocpus         = each.value.ocpus
    }

    vnics {
        subnet_id             = each.value.subnet_id
        is_public_ip_assigned = false
        hostname_label        = each.value.hostname_label
    }

    dynamic "containers" {
        for_each = each.value.containers
        content {
            display_name          = containers.value.display_name
            image_url             = containers.value.image_url
            environment_variables = try(containers.value.environment_variables, null)

            command               = try(containers.value.command, null)
            arguments             = try(containers.value.arguments, null)

            dynamic "volume_mounts" {
                for_each = containers.value.volume_mounts == null ? [] : containers.value.volume_mounts
                content {
                    volume_name = volume_mounts.value.volume_name
                    mount_path  = volume_mounts.value.mount_path
                }
            }

            resource_config {
                memory_limit_in_gbs = try(containers.value.memory_limit_in_gbs, null)
                vcpus_limit         = try(containers.value.vcpus_limit, null)
            }

            working_directory       = try(containers.value.working_directory, null)
        }
    }
}
