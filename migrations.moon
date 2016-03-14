import mixin_table from require "moon"
import create_table, types, add_column from require "lapis.db.schema"

migrations={
  profiles_000001: =>
    create_table "profiles", {
      {"id", types.serial}
      {"user_id", types.integer}
      "PRIMARY KEY (id)"
    }

}

mixin_table migrations, require "lazuli.modules.user_management.migrations"

migrations
