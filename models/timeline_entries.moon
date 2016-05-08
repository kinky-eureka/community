import Model, enum from require "lapis.db.model"
import create_table, types, add_column, drop_column from require "lapis.db.schema"
import band, bor from require "bit"
Users = require "lazuli.modules.user_management.models.users"
config = (require "lapis.config").get!

class Timeline_Entries extends Model
  @relations: {
    {"user",               belongs_to: "Users"}
    {"acl",                belongs_to: "ACLs"}
  }

  @types: enum {
    text: 1
    image: 2
    video: 3
    comment: 4
    like: 5
    profile: 6
  }

  @get_relation_model: (name)=> switch name
    when "Users"
      require "lazuli.modules.user_management.models.users"
    when "ACLs"
      require "models.acls"

  @migrations: {
    ->
      create_table "timeline_entries", {
        {"id", types.serial}
        {"user_id", types.integer}
        {"acl_id", types.integer}
        {"type", types.integer}
        {"target_id", types.integer}
        "PRIMARY KEY (id)"
      }

  }
