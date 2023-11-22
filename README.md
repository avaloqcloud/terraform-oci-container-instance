[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/avaloqcloud/terraform-oci-container-instance/archive/refs/tags/v0.1.0.zip)

[![Generate terraform docs](https://github.com/avaloqcloud/terraform-oci-container-instance/actions/workflows/documentation.yml/badge.svg)](https://github.com/avaloqcloud/terraform-oci-container-instance/actions/workflows/documentation.yml)

## Terraform OCI Container Instance
The code provides a reusable Terraform module that provisions a container instance on Oracle Cloud Infrastructure.

For the nitty-gritty details, see the [CHANGELOG.md](CHANGELOG.md) file.

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement_terraform) (~> 1.2)

- <a name="requirement_oci"></a> [oci](#requirement_oci) (5.18.0)

## Providers

The following providers are used by this module:

- <a name="provider_oci"></a> [oci](#provider_oci) (5.18.0)

## Resources

The following resources are used by this module:

- [oci_container_instances_container_instance.this](https://registry.terraform.io/providers/oracle/oci/5.18.0/docs/resources/container_instances_container_instance) (resource)
- [oci_container_instances_container_instance.existing_resource](https://registry.terraform.io/providers/oracle/oci/5.18.0/docs/data-sources/container_instances_container_instance) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_container_instance"></a> [container_instance](#input_container_instance)

Description: Container Instance input object.

Type:

```hcl
object({
        compartment_ocid         = string
        container_instance_id    = optional(string) # Required for lookup
        availability_domain      = string
        display_name             = string # ^[a-z0-9-]+$
        shape                    = string
        hostname_label           = string # ^[a-z0-9-]+$
        subnet_id                = string
        container_restart_policy = string # ["NEVER", "ALWAYS", "ON_FAILURE"]
        memory_in_gbs            = number
        ocpus                    = number
        containers               = list(object({
            display_name          = string
            image_url             = string
            environment_variables = optional(map(string))

            command   = optional(list(string))
            arguments = optional(list(string))

            volume_mounts = optional(list(object({
                volume_name = string
                mount_path  = string
            })))

            resource_config = optional(map(object({
                memory_limit_in_gbs = optional(number)
                vcpus_limit         = optional(number)
            })))

            memory_limit_in_gbs = optional(number)
            vcpus_limit         = optional(number)

            working_directory = optional(string)
        }))
        volumes = optional(list(object({
            name          = string
            volume_type   = string
            backing_store = optional(string)

            configs = optional(list(object({
                data      = optional(string)
                file_name = optional(string)
            })))
        })))
        image_pull_secrets = optional(list(object({
            registry_endpoint = string
            secret_type       = string
            secret_id         = optional(string)
            username          = optional(string)
            password          = optional(string)
        })))
    })
```

## Outputs

The following outputs are exported:

### <a name="output_container_instance"></a> [container_instance](#output_container_instance)

Description: Container Instance output object.
<!-- END_TF_DOCS -->
