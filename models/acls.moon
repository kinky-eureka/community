import Model, enum from require "lapis.db.model"
import create_table, types, add_column from require "lapis.db.schema"
Users = require "lazuli.modules.user_management.models.users"

class ACLs extends Model

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
