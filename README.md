# Terraform OCI Container Instance

The code provides a reusuable Terraform module that provisions
simple container instance on Oracle Cloud Infrastructure.

## Usage
    module "container_instance" {
      source = "../terraform-oci-container-instance"

      compartment_ocid   = var.compartment_ocid
      subnet_id          = var.subnet_id
      container_instance = var.container_instance
      image_pull_secrets = var.image_pull_secrets
    }

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | >= 4.101.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | >= 4.101.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_container_instances_container_instance.container_instance](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/container_instances_container_instance) | resource |
| [oci_identity_availability_domains.local_ads](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_availability_domains) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_ocid"></a> [compartment\_ocid](#input\_compartment\_ocid) | n/a | `string` | `null` | no |
| <a name="input_container_instance"></a> [container\_instance](#input\_container\_instance) | n/a | `any` | n/a | yes |
| <a name="input_image_pull_secrets"></a> [image\_pull\_secrets](#input\_image\_pull\_secrets) | n/a | `map(any)` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | `null` | no |

## Outputs

No outputs.
