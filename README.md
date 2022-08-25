<!-- BEGIN_TF_DOCS -->
# mysql

This module manages MySQL Configuration.

<-- This file is autogenerated, please do not change. -->

## Requirements

| Name | Version |
|------|---------|
| terraform | >=1.1 |
| mysql | >=3.0 |

## Providers

| Name | Version |
|------|---------|
| mysql | >=3.0 |

## Resources

| Name | Type |
|------|------|
| mysql_database.database | resource |
| mysql_grant.grant | resource |
| mysql_role.user | resource |
| mysql_user.user | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| mysql_database | resource definition, default settings are defined within locals and merged with var settings | `any` | `{}` | no |
| mysql_grant | resource definition, default settings are defined within locals and merged with var settings | `any` | `{}` | no |
| mysql_role | resource definition, default settings are defined within locals and merged with var settings | `any` | `{}` | no |
| mysql_user | resource definition, default settings are defined within locals and merged with var settings | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| mysql_database | mysql_database results |
| mysql_user | mysql_user results |

## Examples

```hcl
module "mysql_configuration" {
  source = "registry.terraform.io/T-Systems-MMS/mysql/mysql"
  mysql_database = {
    web_db = {}
  }
  mysql_user = {
    webuser = {
      host               = "%"
      plaintext_password = random_string.password["webuser"].result
    }
  }
  mysql_grant = {
    webuser = {
      database   = module.mysql_configuration.mysql_database["web_db"].name
      user       = module.mysql_configuration.mysql_user["webuser"].user
      host       = module.mysql_configuration.mysql_user["webuser"].host
      privileges = ["ALL"]
    }
  }
}
```
<!-- END_TF_DOCS -->