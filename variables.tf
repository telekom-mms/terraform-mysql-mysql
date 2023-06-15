variable "user" {
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
  user = {
    for user in keys(var.user) :
    user => merge(local.default.user, var.user[user])
  }
  grant = {
    for grant in keys(var.grant) :
    grant => merge(local.default.grant, var.grant[grant])
  }
}
