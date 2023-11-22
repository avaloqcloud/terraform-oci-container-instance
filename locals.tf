locals {
    helper_resource_map = {
        "resource" = {
            container_instance_id    = var.container_instance.container_instance_id != null ? var.container_instance.container_instance_id : null
            compartment_ocid         = var.container_instance.compartment_ocid
            availability_domain      = var.container_instance.availability_domain
            display_name             = var.container_instance.display_name
            shape                    = var.container_instance.shape
            hostname_label           = var.container_instance.hostname_label
            subnet_id                = var.container_instance.subnet_id
            container_restart_policy = var.container_instance.container_restart_policy
            memory_in_gbs            = var.container_instance.memory_in_gbs
            ocpus                    = var.container_instance.ocpus
            containers               = var.container_instance.containers
            volumes                  = var.container_instance.volumes
            image_pull_secrets       = var.container_instance.image_pull_secrets
        }
    }

    potential_resource = length(data.oci_container_instances_container_instance.existing_resource) < 1 ? var.container_instance != null ? {
        for flat_container_instance in flatten([
            for k, v in local.helper_resource_map : {
                container_instance_id    = null
                k                        = k
                compartment_ocid         = v.compartment_ocid
                availability_domain      = v.availability_domain
                display_name             = v.display_name
                shape                    = v.shape
                hostname_label           = v.hostname_label
                subnet_id                = v.subnet_id
                container_restart_policy = v.container_restart_policy
                memory_in_gbs            = v.memory_in_gbs
                ocpus                    = v.ocpus
                containers               = v.containers
                volumes                  = v.volumes
                image_pull_secrets       = v.image_pull_secrets
            }
        ]) : flat_container_instance.k => flat_container_instance
    } : {} : {}

    output_container_instance = merge(oci_container_instances_container_instance.this, data.oci_container_instances_container_instance.existing_resource)
}
