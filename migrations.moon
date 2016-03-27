import mixin_table from require "moon"
import create_table, types, add_column from require "lapis.db.schema"

migrations={}

mixin_model=(name)-> mixin_table migrations, {"%s_%06d"\format(name,k), v for k,v in pairs (require "models."..name).migrations}

mixin_table migrations, require "lazuli.modules.user_management.migrations"

mixin_model "profiles"
mixin_model "acls"
mixin_model "acl_entries"

migrations
