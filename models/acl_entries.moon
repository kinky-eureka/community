import Model, enum from require "lapis.db.model"
import create_table, types, add_column from require "lapis.db.schema"
Users = require "lazuli.modules.user_management.models.users"

class ACL_Entries extends Model

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
