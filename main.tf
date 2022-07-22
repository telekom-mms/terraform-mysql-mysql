/**
 * # mysql
 *
 * This module manages MySQL Configuration.
 *
*/

resource "mysql_database" "database" {
  for_each = local.mysql_database

  name                  = local.mysql_database[each.key].name == "" ? each.key : local.mysql_database[each.key].name
  default_character_set = local.mysql_database[each.key].default_character_set
  default_collation     = local.mysql_database[each.key].default_collation
}

resource "mysql_user" "user" {
  for_each = local.mysql_user

  user               = local.mysql_user[each.key].user == "" ? each.key : local.mysql_user[each.key].user
  host               = local.mysql_user[each.key].host
  plaintext_password = local.mysql_user[each.key].plaintext_password
  tls_option         = local.mysql_user[each.key].tls_option
}

resource "mysql_role" "user" {
  for_each = local.mysql_role

  name = local.mysql_role[each.key].name == "" ? each.key : local.mysql_role[each.key].name
}

resource "mysql_grant" "grant" {
  for_each = local.mysql_user

  user       = local.mysql_grant[each.key].user
  host       = local.mysql_grant[each.key].host
  role       = local.mysql_grant[each.key].role
  database   = local.mysql_grant[each.key].database
  table      = local.mysql_grant[each.key].table
  privileges = local.mysql_grant[each.key].privileges
  roles      = local.mysql_grant[each.key].roles
  grant      = local.mysql_grant[each.key].grant
}
