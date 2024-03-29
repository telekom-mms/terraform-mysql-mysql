<!-- BEGIN_TF_DOCS -->
# mysql

This module manages the mysql resources.
For more information see https://registry.terraform.io/providers/petoju/mysql/latest/docs

_<-- This file is autogenerated, please do not change. -->_

## Requirements

| Name | Version |
|------|---------|
| terraform | >=1.4 |
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
| mysql_role.role | resource |
| mysql_user.user | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| database | Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs). | `any` | `{}` | no |
| grant | Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs). | `any` | `{}` | no |
| role | Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs). | `any` | `{}` | no |
| user | Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs). | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| database | Outputs all attributes of resource_type. |
| grant | Outputs all attributes of resource_type. |
| role | Outputs all attributes of resource_type. |
| user | Outputs all attributes of resource_type. |
| variables | Displays all configurable variables passed by the module. __default__ = predefined values per module. __merged__ = result of merging the default values and custom values passed to the module |

## Examples

Minimal configuration to install the desired resources with the module

```hcl
resource "random_password" "password" {
  for_each = toset(["mysql_root"])

  length  = 16
  special = false
}

module "database" {
  source = "registry.terraform.io/telekom-mms/database/azurerm"
  mysql_flexible_server = {
    mysql-mms = {
      location               = "westeurope"
      resource_group_name    = "rg-mms-github"
      administrator_login    = "mysql_root"
      administrator_password = random_password.password["mysql_root"].result
      sku_name               = "GP_Standard_D2ds_v4"
      version                = "8.0.21"
    }
  }
}

module "mysql" {
  source = "registry.terraform.io/telekom-mms/mysql/mysql"
  database = {
    application = {}
  }
  user = {
    mms     = {}
    mms-dev = {}
  }
  role = {
    developer = {}
  }
  grant = {
    mms = {
      database = module.mysql.database["application"].name
    }
    mms-dev = {
      database = module.mysql.database["application"].name
      roles    = [module.mysql.role["developer"].name]
    }
  }
}
```

Advanced configuration to install the desired resources with the module

```hcl
resource "random_password" "password" {
  for_each = toset(["mysql_root", "mms", "mms-dev"])

  length  = 16
  special = false
}

module "database" {
  source = "registry.terraform.io/telekom-mms/database/azurerm"
  mysql_flexible_server = {
    mysql-mms = {
      location               = "westeurope"
      resource_group_name    = "rg-mms-github"
      administrator_login    = "mysql_root"
      administrator_password = random_password.password["mysql_root"].result
      sku_name               = "GP_Standard_D2ds_v4"
      version                = "8.0.21"
    }
  }
}

module "mysql" {
  source = "registry.terraform.io/telekom-mms/mysql/mysql"
  database = {
    application = {
      default_character_set = "utf8mb4"
      default_collation     = "utf8mb4_general_ci"
    }
  }
  user = {
    mms = {
      host               = "172.0.0.1"
      plaintext_password = random_password.password["mms"].result
    }
    mms-dev = {
      host               = "172.0.0.2"
      plaintext_password = random_password.password["mms-dev"].result
    }
  }
  role = {
    developer = {}
  }
  grant = {
    mms = {
      user       = module.mysql.user["mms"].user
      host       = module.mysql.user["mms"].host
      database   = module.mysql.database["application"].name
      privileges = ["ALL"]
      grant      = true
    }
    mms-dev = {
      user     = module.mysql.user["mms-dev"].user
      host     = module.mysql.user["mms-dev"].host
      database = module.mysql.database["application"].name
      roles    = [module.mysql.role["developer"].name]
    }
  }
}
```
<!-- END_TF_DOCS -->