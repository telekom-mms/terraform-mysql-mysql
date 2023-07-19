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
