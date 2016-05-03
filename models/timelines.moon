import Model, enum from require "lapis.db.model"
import create_table, types, add_column, drop_column from require "lapis.db.schema"
import band, bor from require "bit"
Users = require "lazuli.modules.user_management.models.users"
config = (require "lapis.config").get!

class Timelines extends Model
  @relations: {
    {"user",               belongs_to: "Users"}
    {"acl",                belongs_to: "ACLs"}
    {"flags",              fetch: =>
      @flags={}
      for k,v in pairs @@flags_values
        if type(k)=="number" and 0~=band(@flags_mask, 2^k)
          @flags[v]=true
    }
  }
  @constraints: {
    flags: (tbl,_,obj) =>
      val=0
      for k,v in pairs @flags_values
        if type(k)=="number" and tbl[v]
          val=bor(val,2^k)
      obj.flags_mask=val
      false
  }


  @flags_values: {
    "markdown_posts"
    "image_posts"
    "video_posts"
    "profile_updates"
    "comments"
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
        {"flags_mask", types.integer}
        "PRIMARY KEY (id)"
      }

  }
