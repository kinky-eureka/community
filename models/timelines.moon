import Model, enum from require "lapis.db.model"
import create_table, types, add_column, drop_column from require "lapis.db.schema"
import band, bor from require "bit"
import list from require "lapis.db"
import to_json, from_json from require "lapis.util"
Users = require "lazuli.modules.user_management.models.users"
Timeline_Entries = require "models.timeline_entries"
import OrderedPaginator from require "lapis.db.pagination"
config = (require "lapis.config").get!

class Timelines extends Model
  @relations: {
    {"user",               belongs_to: "Users"}
    {"acl",                belongs_to: "ACLs"}
  }

  fetchEntries: do
    local all_users
    (per_page=nil)=>
      cuname = "users-"..@acl_id
      users = ngx.shared.timeline_cache\get cuname
      if not users
        acl = @get_acl!
        all_users or= Users\select!
        users=list [u.id for u in *all_users when acl\matchUser u]
        ngx.shared.timeline_cache\set cuname, users, 30
      ctname = "types-"..@id
      types = ngx.shared.timeline_cache\get ctname
      if not types
        types=list [k for k,v in ipairs Timeline_Entries.types when @["flag_include_"..v.."s"]]
        ngx.shared.timeline_cache\set ctname, types, 30
      OrderedPaginator Timeline_Entries "id", [[where "user_id" in ? and "type" in ?]], users, types, {
        per_page: per_page
        order: "desc"
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
