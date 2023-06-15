/**
* # mysql
*
* This module manages the mysql resources.
* For more information see https://registry.terraform.io/providers/petoju/mysql/latest/docs
*
*/

resource "mysql_user" "user" {
  for_each = local.user

  user               = local.user[each.key].user == "" ? each.key : local.user[each.key].user
  host               = local.user[each.key].host
  plaintext_password = local.user[each.key].plaintext_password
  password           = local.user[each.key].password
  auth_plugin        = local.user[each.key].auth_plugin
  auth_string_hashed = local.user[each.key].auth_string_hashed
  #aad_identity = local.user[each.key].aad_identity
  tls_option = local.user[each.key].tls_option
}

resource "mysql_grant" "grant" {
  for_each = local.grant

  user       = local.grant[each.key].user
  host       = local.grant[each.key].host
  role       = local.grant[each.key].role
  database   = local.grant[each.key].database
  table      = local.grant[each.key].table
  privileges = local.grant[each.key].privileges
  roles      = local.grant[each.key].roles
  tls_option = local.grant[each.key].tls_option
  grant      = local.grant[each.key].grant
}
