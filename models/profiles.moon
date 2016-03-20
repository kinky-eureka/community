import Model, enum from require "lapis.db.model"
import create_table, types, add_column from require "lapis.db.schema"
Users = require "lazuli.modules.user_management.models.users"

class Profiles extends Model
  @getOrCreateByUser: (user)=>
    if type(user)=="number"
      user=Users\find user
    return nil, "user not found" unless user
    obj=(@find{user_id: user.id}) or (@create{user_id: user.id})
    @@preload_relations {obj}, unpack [i[1] for i in *@@relations]
    obj

  @relations: {
    {"user", belongs_to: "Users"}
  }

  @get_relation_model: (name)=> switch name
    when "Users"
      require "lazuli.modules.user_management.models.users"

  @migrations: {
    ->
      create_table "profiles", {
        {"id", types.serial}
        {"user_id", types.integer}
        "PRIMARY KEY (id)"
      }
    ->
      add_column "profiles", "birthday", types.date null: true
      add_column "profiles", "about", types.text null: true
    ->
      add_column "profiles", "privacy_birthday_dm", types.boolean
      add_column "profiles", "privacy_birthday_y", types.boolean
      add_column "profiles", "privacy_birthday_age", types.boolean default: true
    ->
      add_column "profiles", "gender", types.varchar null: true
      add_column "profiles", "privacy_gender", types.boolean
  }
