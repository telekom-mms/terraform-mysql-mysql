terraform {
  required_providers {
    mysql = {
      source  = "registry.terraform.io/petoju/mysql"
      version = ">=3.0"
    }
  }
  required_version = ">=1.1"
}
