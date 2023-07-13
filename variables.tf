variable "user" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "database" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "role" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "grant" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

locals {
  default = {
    database = {
      name                  = ""
      default_character_set = null
      default_collation     = null
    }
    user = {
      user               = ""
      host               = null
      plaintext_password = null
      password           = null
      auth_plugin        = null
      auth_string_hashed = null
      aad_identity       = null
      tls_option         = null
    }
    role = {
      name = ""
    }
    grant = {
      user       = null
      host       = null
      role       = null
      table      = null
      privileges = null
      roles      = null
      tls_option = null
      grant      = null
    }
  }

  // compare and merge custom and default values
  // deep merge of all custom and default values
  database = {
    for database in keys(var.database) :
    database => merge(local.default.database, var.database[database])
  }
  user = {
    for user in keys(var.user) :
    user => merge(local.default.user, var.user[user])
  }
  role = {
    for role in keys(var.role) :
    role => merge(local.default.role, var.role[role])
  }
  grant = {
    for grant in keys(var.grant) :
    grant => merge(local.default.grant, var.grant[grant])
  }
}
