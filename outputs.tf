output "database" {
  description = "mysql_database results"
  value = {
    for database in keys(mysql_database.database) :
    database => {
      id                    = mysql_database.database[database].id
      name                  = mysql_database.database[database].name
      default_character_set = mysql_database.database[database].default_character_set
      default_collation     = mysql_database.database[database].default_collation
    }
  }
}

output "user" {
  description = "mysql_user results"
  value = {
    for user in keys(mysql_user.user) :
    user => {
      user = mysql_user.user[user].user
      id   = mysql_user.user[user].id
      host = mysql_user.user[user].host
    }
  }
}
