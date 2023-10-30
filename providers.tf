terraform {
    experiments = [module_variable_optional_attrs]
    required_version = "~> 1.2"
    required_providers {
        oci = {
            source  = "oracle/oci"
            version = "5.18.0"
        }
    }
}
