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
      user = {
        for key in keys(var.user) :
        key => local.user[key]
      }
      grant = {
        for key in keys(var.grant) :
        key => local.grant[key]
      }
    }
  }
}
