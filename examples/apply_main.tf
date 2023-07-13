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
