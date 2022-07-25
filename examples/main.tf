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
