import Model, enum from require "lapis.db.model"
import create_table, types, add_column from require "lapis.db.schema"

Users = require "lazuli.modules.user_management.models.users"
ACL_Entries = require "models.acl_entries"


class ACLs extends Model

  matchUser: (user,return_default=true)=>
    if user ~= -1
      if type(user)=="number"
        user=Users\find user
      return nil, "user not found" unless user
    entries=ACL_Entries\select "where acl_id = ? order by position asc nulls first, id", @id
    for entry in *entries
      ret, err=entry\matchUser user
      return true     if ret == true
      return false    if ret == false
      return nil, err if ret == nil and err
    if return_default
      return @default_policy

  @relations: {
    {"user", belongs_to: "Users"}
  }

  @get_relation_model: (name)=> switch name
    when "Users"
      require "lazuli.modules.user_management.models.users"
    when "ACLs"
      require "models.acls"

  @migrations: {
    ->
      create_table "acls", {
        {"id",             types.serial}
        {"user_id",        types.integer}
        {"name",           types.varchar}
        {"default_policy", types.boolean}
        "PRIMARY KEY (id)"
      }
  }
