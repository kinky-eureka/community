import Model, enum from require "lapis.db.model"
import create_table, types, add_column from require "lapis.db.schema"

Users = require "lazuli.modules.user_management.models.users"
ACL_Entries = require "models.acl_entries"


class ACLs extends Model

  -- user is one of:
  --  * "lazuli.modules.user_management.models.users" instance
  --  * user id (number) to be found by that model
  --  * nil if no user is logged in/applicable
  matchUser: do
    _logic= (user,return_default=true)=>
      entries=ACL_Entries\select "where acl_id = ? order by position asc nulls first, id", @id
      for entry in *entries
        ret, err=entry\matchUser user
        return nil, err if ret == nil and err
        return ret if type(ret)=="boolean"
      if return_default
        return @default_policy
    (user,return_default=true)=>
      if user
        if type(user)=="number"
          user=Users\find user
        return nil, "user not found" unless user
      cname=(user and tostring(user.id) or "[nil]").."-"..@id
      cached=ngx.shared.acl_cache\get cname
      return cached if cached ~= nil
      ret,err=_logic user, return_default
      if type(ret)=="boolean"
        ngx.shared.acl_cache\set cname, ret, 10
      return ret, err


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
