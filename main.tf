resource "oci_container_instances_container_instance" "container_instance" {

    availability_domain = var.availability_domain
    compartment_id      = var.compartment_ocid

    display_name             = try(var.display_name, null)
    container_restart_policy = var.container_restart_policy
    shape                    = var.shape
    shape_config {
        memory_in_gbs = var.memory_in_gbs
        ocpus         = var.ocpus
    }

    vnics {
        subnet_id             = var.subnet_id
        is_public_ip_assigned = false
        hostname_label        = try(var.hostname_label, null)
    }

    dynamic "containers" {
        for_each = var.containers
        content {
            display_name          = try(containers.value.display_name, null)
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

            working_directory     = try(containers.value.working_directory, null)
        }
    }

    dynamic "volumes" {
        for_each = var.volumes
        content {
            name          = volumes.value.name
            volume_type   = volumes.value.volume_type
            backing_store = try(volumes.value.backing_store, null)

            dynamic "configs" {
                for_each = volumes.value.configs == null ? [] : volumes.value.configs
                content {
                    data      = configs.value.data
                    file_name = configs.value.file_name
                }
            }
        }
    }

    dynamic "image_pull_secrets" {
        for_each = var.image_pull_secrets
        content {
            registry_endpoint = image_pull_secrets.value.registry_endpoint
            secret_type       = image_pull_secrets.value.secret_type

            secret_id = try(image_pull_secrets.value.secret_id, null)
            username  = base64encode(try(image_pull_secrets.value.username, null))
            password  = base64encode(try(image_pull_secrets.value.password, null))
        }
    }
}
