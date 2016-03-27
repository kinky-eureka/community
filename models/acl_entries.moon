import Model, enum from require "lapis.db.model"
import create_table, types, add_column from require "lapis.db.schema"

Users = require "lazuli.modules.user_management.models.users"
ACLs = require "models.acls"

class ACL_Entries extends Model

  matchUser: (user)=>
    if user
      if type(user)=="number"
        user=Users\find user
      return nil, "user not found" unless user
    switch @target_type
      when @@target_types.user
        if user and @target_id == user.id
          return @policy
      when @@target_types.include, @@target_types.include_inverted
        switch @target_id
          when @@special_targets.include_everyone
            return @policy
          when @@special_targets.include_logged_in
            return @policy if user
          else
            list=ACLs\find @target_id
            return nil, "include "..tostring(@target_id).." not found" unless list
            ret=list\matchUser user, false
            return nil, err if ret == nil and err
            if type(ret)=="boolean"
              return not ret if @target_type == @@target_types.include_inverted
              return ret


  @relations: {
    {"acl", belongs_to: "ACLs"}
    --{"target_user", belongs_to: "Users"}
    --{"target_include", belongs_to: "ACLs"}
  }

  @get_relation_model: (name)=> switch name
    when "Users"
      require "lazuli.modules.user_management.models.users"
    when "ACLs"
      require "models.acls"

  @target_types: enum {
    include: 1
    include_inverted: 2
    user: 3
  }

  @special_targets: enum {
    include_everyone: -1
    include_logged_in: -2
  }

  @migrations: {
    ->
      create_table "acl_entries", {
        {"id",                types.serial}
        {"acl_id",            types.integer}
        {"position",          types.integer default: 0}
        {"policy",            types.boolean}
        {"target_type",       types.integer}
        {"target_id",         types.integer null: true}
        "PRIMARY KEY (id)"
      }
  }
