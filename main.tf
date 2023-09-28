data "oci_identity_availability_domains" "local_ads" {
  compartment_id = var.compartment_ocid
}


resource "oci_container_instances_container_instance" "container_instance" {
  count = length(var.container_instance)

  availability_domain = data.oci_identity_availability_domains.local_ads.availability_domains.0.name
  compartment_id      = var.compartment_ocid

  display_name             = var.container_instance[count.index]["container_name"]
  container_restart_policy = "ALWAYS"
  shape                    = var.container_instance[count.index]["shape"]
  shape_config {
    memory_in_gbs = var.container_instance[count.index]["mem"]
    ocpus         = var.container_instance[count.index]["cpu"]
  }

  vnics {
    subnet_id             = var.subnet_id
    is_public_ip_assigned = false
  }

  containers {
    image_url    = var.container_instance[count.index]["container_image_url"]
    display_name = var.container_instance[count.index]["container_name"]

    environment_variables = var.container_instance[count.index]["env_variables"]

    command   = try(var.container_instance[count.index]["command"], null)
    arguments = try(var.container_instance[count.index]["arguments"], null)

    dynamic "volume_mounts" {
      for_each = try(var.container_instance[count.index]["volumes"], {})
      content {
        volume_name = volume_mounts.key
        mount_path  = volume_mounts.value.path
      }
    }

    resource_config {
      memory_limit_in_gbs = try(var.container_instance[count.index]["memory_limit"], null)
    }

    security_context {
      run_as_group          = try(var.container_instance[count.index]["run_as_group"], null)
      run_as_user           = try(var.container_instance[count.index]["run_as_user"], null)
      security_context_type = "LINUX"
    }

    working_directory = try(var.container_instance[count.index]["working_directory"], null)
  }

  dynamic "image_pull_secrets" {
    for_each = try(var.image_pull_secrets, {})
    content {
      registry_endpoint = image_pull_secrets.value.registry_endpoint
      secret_type       = image_pull_secrets.value.secret_type

      secret_id = try(image_pull_secrets.value.secret_id, null)
      username  = base64encode(try(image_pull_secrets.value.username, null))
      password  = base64encode(try(image_pull_secrets.value.password, null))
    }
  }

  dynamic "volumes" {
    for_each = try(var.container_instance[count.index]["volumes"], {})
    content {
      name          = volumes.key
      volume_type   = volumes.value.volume_type
      backing_store = try(volumes.value.backing_store, null)
      dynamic "configs" {
        for_each = try(volumes.value.configs, {})
        content {
          data      = try(configs.value, null)
          file_name = try(configs.key, null)
        }
      }
    }
  }
}
