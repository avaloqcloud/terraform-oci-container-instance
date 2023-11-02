[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/avaloqcloud/terraform-oci-container-instance/archive/refs/tags/v0.1.0.zip)

[![Generate terraform docs](https://github.com/avaloqcloud/terraform-oci-container-instance/actions/workflows/documentation.yml/badge.svg)](https://github.com/avaloqcloud/terraform-oci-container-instance/actions/workflows/documentation.yml)

## Terraform OCI Container Instance
The code provides a reusable Terraform module that provisions a container instance on Oracle Cloud Infrastructure.

For the nitty-gritty details, see the [CHANGELOG.md](CHANGELOG.md) file.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.2 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | 5.18.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 5.18.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_container_instances_container_instance.container_instance](https://registry.terraform.io/providers/oracle/oci/5.18.0/docs/resources/container_instances_container_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_domain"></a> [availability\_domain](#input\_availability\_domain) | The availability domain where the container instance runs. | `string` | n/a | yes |
| <a name="input_compartment_ocid"></a> [compartment\_ocid](#input\_compartment\_ocid) | The OCID of the compartment. | `string` | n/a | yes |
| <a name="input_container_restart_policy"></a> [container\_restart\_policy](#input\_container\_restart\_policy) | The container restart policy is applied for all containers in container instance. | `string` | `"ALWAYS"` | no |
| <a name="input_containers"></a> [containers](#input\_containers) | The containers to create on this container instance. | <pre>list(object({<br>        display_name          = optional(string)<br>        image_url             = string<br>        environment_variables = optional(map(string))<br><br>        command               = optional(list(string))<br>        arguments             = optional(list(string))<br><br>        volume_mounts         = optional(list(object({<br>            volume_name = string<br>            mount_path  = string<br>        })))<br><br>        resource_config = optional(map(object({<br>            memory_limit_in_gbs = optional(number)<br>            vcpus_limit         = optional(number)<br>        })))<br><br>        memory_limit_in_gbs   = optional(number)<br>        vcpus_limit           = optional(number)<br><br>        working_directory     = optional(string)<br>    }))</pre> | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. If you don't provide a name, a name is generated automatically. | `string` | `null` | no |
| <a name="input_hostname_label"></a> [hostname\_label](#input\_hostname\_label) | The hostname (DNS) name of the container instance. | `string` | `null` | no |
| <a name="input_image_pull_secrets"></a> [image\_pull\_secrets](#input\_image\_pull\_secrets) | The image pulls secrets so you can access private registry to pull container images. | <pre>list(object({<br>        registry_endpoint = string<br>        secret_type       = string<br>        secret_id         = optional(string)<br>        username          = optional(string)<br>        password          = optional(string)<br>    }))</pre> | `[]` | no |
| <a name="input_memory_in_gbs"></a> [memory\_in\_gbs](#input\_memory\_in\_gbs) | The total amount of memory available to the container instance, in gigabytes. | `number` | n/a | yes |
| <a name="input_ocpus"></a> [ocpus](#input\_ocpus) | The total number of OCPUs available to the container instance. | `number` | n/a | yes |
| <a name="input_shape"></a> [shape](#input\_shape) | The shape of the container instance. The shape determines the resources available to the container instance. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The OCID of the subnet to create the VNIC in. | `string` | n/a | yes |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | A volume is a directory with data that is accessible across multiple containers in a container instance. | <pre>list(object({<br>        name          = string<br>        volume_type   = string<br>        backing_store = optional(string)<br><br>        configs       = optional(list(object({<br>            data      = optional(string)<br>            file_name = optional(string)<br>        })))<br>    }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
