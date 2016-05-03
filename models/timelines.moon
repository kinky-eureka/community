import Model, enum from require "lapis.db.model"
import create_table, types, add_column, drop_column from require "lapis.db.schema"
import band, bor from require "bit"
Users = require "lazuli.modules.user_management.models.users"
config = (require "lapis.config").get!

class Timelines extends Model
  @relations: {
    {"user",               belongs_to: "Users"}
    {"acl",                belongs_to: "ACLs"}
  }

  @get_relation_model: (name)=> switch name
    when "Users"
      require "lazuli.modules.user_management.models.users"
    when "ACLs"
      require "models.acls"

  @migrations: {
    ->
      create_table "timelines", {
        {"id", types.serial}
        {"user_id", types.integer}
        {"acl_id", types.integer}
        --{"flag_include_posts_text", types.boolean}
        --{"flag_include_posts_image", types.boolean}
        --{"flag_include_posts_video", types.boolean}
        --{"flag_include_comments", types.boolean}
        --{"flag_include_likes", types.boolean}
        --{"flag_include_profiles", types.boolean}
        "PRIMARY KEY (id)"
      }

  }
