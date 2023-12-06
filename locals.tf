locals {
    
    potential_resource = length(data.oci_container_instances_container_instances.existing_resource.container_instance_collection[0].items) < 1 ? {
	"resource" = {
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
    } : {}

    pre_existing_output_container_instance = length(data.oci_container_instances_container_instances.existing_resource.container_instance_collection[0].items) > 0 ? {
      	"resource" = {
      	    compartment_ocid         = data.oci_container_instances_container_instances.existing_resource.container_instance_collection[0].items[0].compartment_id
            availability_domain      = data.oci_container_instances_container_instances.existing_resource.container_instance_collection[0].items[0].availability_domain                              
            display_name             = data.oci_container_instances_container_instances.existing_resource.container_instance_collection[0].items[0].display_name
            shape                    = data.oci_container_instances_container_instances.existing_resource.container_instance_collection[0].items[0].shape
            #hostname_label           = data.oci_container_instances_container_instances.existing_resource.container_instance_collection[0].items[0].hostname_label
            #subnet_id                = data.oci_container_instances_container_instances.existing_resource.container_instance_collection[0].items[0].subnet_id
            container_restart_policy = data.oci_container_instances_container_instances.existing_resource.container_instance_collection[0].items[0].container_restart_policy
            #memory_in_gbs            = data.oci_container_instances_container_instances.existing_resource.container_instance_collection[0].items[0].shape_config.memory_in_gbs
            #ocpus                    = data.oci_container_instances_container_instances.existing_resource.container_instance_collection[0].items[0].shape_config.ocpus
            containers               = data.oci_container_instances_container_instances.existing_resource.container_instance_collection[0].items[0].containers
            volumes                  = data.oci_container_instances_container_instances.existing_resource.container_instance_collection[0].items[0].volumes
            image_pull_secrets       = data.oci_container_instances_container_instances.existing_resource.container_instance_collection[0].items[0].image_pull_secrets
        }
    } : {}

    output_container_instance = merge(oci_container_instances_container_instance.this, local.pre_existing_output_container_instance)
}
