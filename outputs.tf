output "database" {
  description = "Outputs all attributes of resource_type."
  value = {
    for database in keys(mysql_database.database) :
    database => {
      for key, value in mysql_database.database[database] :
      key => value
    }
  }
}

output "user" {
  description = "Outputs all attributes of resource_type."
  value = {
    for user in keys(mysql_user.user) :
    user => {
      for key, value in mysql_user.user[user] :
      key => value
    }
  }
}

output "role" {
  description = "Outputs all attributes of resource_type."
  value = {
    for role in keys(mysql_role.role) :
    role => {
      for key, value in mysql_role.role[role] :
      key => value
    }
  }
}

output "grant" {
  description = "Outputs all attributes of resource_type."
  value = {
    for grant in keys(mysql_grant.grant) :
    grant => {
      for key, value in mysql_grant.grant[grant] :
      key => value
    }
  }
}

output "variables" {
  description = "Displays all configurable variables passed by the module. __default__ = predefined values per module. __merged__ = result of merging the default values and custom values passed to the module"
  value = {
    default = {
      for variable in keys(local.default) :
      variable => local.default[variable]
    }
    merged = {
      database = {
        for key in keys(var.database) :
        key => local.database[key]
      }
      user = {
        for key in keys(var.user) :
        key => local.user[key]
      }
      role = {
        for key in keys(var.role) :
        key => local.role[key]
      }
      grant = {
        for key in keys(var.grant) :
        key => local.grant[key]
      }
    }
  }
}
