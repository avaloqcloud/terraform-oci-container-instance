variable "compartment_ocid" {
  type        = string
  description = "The OCID of the compartment."
}

variable "availability_domain" {
    type        = string
    description = "The availability domain where the container instance runs."
}

variable "display_name" {
    type        = string
    default     = null
    description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. If you don't provide a name, a name is generated automatically."

    validation {
        condition     = var.display_name == null || can(regex("^[a-z0-9-]+$", var.display_name))
        error_message = "The display_name must contain only letters, numbers or a dash"
    }
}

variable "shape" {
    type        = string
    description = "The shape of the container instance. The shape determines the resources available to the container instance."
}

variable "hostname_label" {
    type        = string
    default     = null
    description = "The hostname (DNS) name of the container instance."
}

variable "subnet_id" {
    type        = string
    description = "The OCID of the subnet to create the VNIC in."
}

variable "container_restart_policy" {
    type        = string
    default     = "ALWAYS"
    description = "The container restart policy is applied for all containers in container instance."

    validation {
        condition     = var.container_restart_policy != "NEVER" || var.container_restart_policy != "ALWAYS" || var.container_restart_policy != "ON_FAILURE"
        error_message = "The container_restart_policy value must be \"ALWAYS\",  \"NEVER\" or \"ON_FAILURE\""
    }
}

variable "memory_in_gbs" {
    type        = number
    description = "The total amount of memory available to the container instance, in gigabytes."
}

variable "ocpus" {
    type        = number
    description = "The total number of OCPUs available to the container instance."
}

variable "containers" {
    type = list(object({
        display_name          = optional(string)
        image_url             = string
        environment_variables = optional(map(string))

        command               = optional(list(string))
        arguments             = optional(list(string))

        volume_mounts         = optional(list(object({
            volume_name = string
            mount_path  = string
        })))

        resource_config = optional(map(object({
            memory_limit_in_gbs = optional(number)
            vcpus_limit         = optional(number)
        })))

        memory_limit_in_gbs   = optional(number)
        vcpus_limit           = optional(number)

        working_directory     = optional(string)
    }))

    description = "The containers to create on this container instance."
}

variable "volumes" {
    type = list(object({
        name          = string
        volume_type   = string
        backing_store = optional(string)

        configs       = optional(list(object({
            data      = optional(string)
            file_name = optional(string)
        })))
    }))

    description = "A volume is a directory with data that is accessible across multiple containers in a container instance."
    default     = []
}

variable "image_pull_secrets" {
    type = list(map(object({
        registry_endpoint = string
        secret_type       = string
        secret_id         = optional(string)
        username          = optional(string)
        password          = optional(string)
    })))

    description = "The image pulls secrets so you can access private registry to pull container images."
    default     = []
}
