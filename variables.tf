variable "compartment_ocid" {
  type    = string
  default = null
}

variable "subnet_id" {
  type    = string
  default = null
}

variable "container_instance" {}

variable "image_pull_secrets" {
  type    = map(any)
  default = {}
}
