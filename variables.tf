variable "compartment_ocid" {}
variable "ad" {}
variable "container_name" {}
variable "container_image_url" {}
variable "shape_config_ocpus" {}
variable "region" {}
variable "env_variables"{
  type = map(any)
  default = {
    environment = "dev"
  }
}