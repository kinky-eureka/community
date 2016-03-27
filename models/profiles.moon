import Model, enum from require "lapis.db.model"
import create_table, types, add_column, drop_column from require "lapis.db.schema"
Users = require "lazuli.modules.user_management.models.users"

class Profiles extends Model
  @getOrCreateByUser: (user)=>
    if type(user)=="number"
      user=Users\find user
    return nil, "user not found" unless user
    (@find{user_id: user.id}) or (@create{user_id: user.id})

  @relations: {
    {"user",            belongs_to: "Users"}
    {"acl_gender",      belongs_to: "ACLs"}
    {"acl_birthday_y",  belongs_to: "ACLs"}
    {"acl_birthday_dm", belongs_to: "ACLs"}
    {"acl_about", belongs_to: "ACLs"}
  }

  @get_relation_model: (name)=> switch name
    when "Users"
      require "lazuli.modules.user_management.models.users"
    when "ACLs"
      require "models.acls"

  @migrations: {
    ->
      create_table "profiles", {
        {"id", types.serial}
        {"user_id", types.integer}
        "PRIMARY KEY (id)"
      }
    ->
      add_column  "profiles", "birthday",             types.date null: true
      add_column  "profiles", "about",                types.text null: true
    ->
      add_column  "profiles", "privacy_birthday_dm",  types.boolean
      add_column  "profiles", "privacy_birthday_y",   types.boolean
      add_column  "profiles", "privacy_birthday_age", types.boolean default: true
    ->
      add_column  "profiles", "gender",               types.varchar null: true
      add_column  "profiles", "privacy_gender",       types.boolean
    ->
      drop_column "profiles", "privacy_gender"
      drop_column "profiles", "privacy_birthday_age"
      drop_column "profiles", "privacy_birthday_y"
      drop_column "profiles", "privacy_birthday_dm"
      add_column  "profiles", "acl_gender_id",        types.integer null: true
      add_column  "profiles", "acl_birthday_dm_id",   types.integer null: true
      add_column  "profiles", "acl_birthday_y_id",    types.integer null: true
    ->
      add_column  "profiles", "acl_about_id",    types.integer null: true
  }
