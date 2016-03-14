import Model from require "lapis.db.model"

class Profiles extends Model
  @relations: {
    {"user", belongs_to: "Users"}
  }
  @get_relation_model: (name)=>
    require "lazuli.modules.user_management.models.users" if name=="Users"
