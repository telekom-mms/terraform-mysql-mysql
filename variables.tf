variable "mysql_database" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "mysql_user" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "mysql_role" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "mysql_grant" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}

locals {
  default = {
    # resource definition
    mysql_database = {
      name                  = ""
      default_character_set = null
      default_collation     = null
      tls_option            = null
    }
    mysql_user = {
      user       = ""
      host       = null
      tls_option = null
    }
    mysql_role = {
      name = ""
    }
    mysql_grant = {
      user       = null
      host       = null
      role       = null
      table      = null
      privileges = null
      roles      = null
      grant      = null
    }
  }

  # compare and merge custom and default values
  # merge all custom and default values
  mysql_database = {
    for mysql_database in keys(var.mysql_database) :
    mysql_database => merge(local.default.mysql_database, var.mysql_database[mysql_database])
  }
  mysql_user = {
    for mysql_user in keys(var.mysql_user) :
    mysql_user => merge(local.default.mysql_user, var.mysql_user[mysql_user])
  }
  mysql_role = {
    for mysql_role in keys(var.mysql_role) :
    mysql_role => merge(local.default.mysql_role, var.mysql_role[mysql_role])
  }
  mysql_grant = {
    for mysql_grant in keys(var.mysql_grant) :
    mysql_grant => merge(local.default.mysql_grant, var.mysql_grant[mysql_grant])
  }
}
