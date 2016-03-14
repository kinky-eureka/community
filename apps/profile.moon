lazuli = require "lazuli"
Profiles = require "models.profiles"
Users = require "lazuli.modules.user_management.models.users"

getOrCreateProfileForUser=(user)->
  if type(user)=="number"
    user=Users\find user
  return nil, "user not found" unless user
  Profiles\find{user_id: user.id} or Profiles\create{user_id: user.id}

class extends lazuli.Application
  @enable "user_management"

  @name: "profile_"
  @path: "/profile"

  [show: "/:id[%d]"]: =>
    @profiledata,err=getOrCreateProfileForUser tonumber @params.id
    if @profiledata
      return render: true
    else
      return status: 404, "Error 404: "..err
