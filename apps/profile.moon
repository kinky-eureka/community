lazuli = require "lazuli"
Profiles = require "models.profiles"


class extends lazuli.Application
  @enable "user_management"

  @name: "profile_"
  @path: "/profile"

  [show: "/:id[%d]"]: =>
    @profiledata,err=Profiles\getOrCreateByUser tonumber @params.id
    if @profiledata
      return render: true
    else
      return status: 404, "Error 404: "..err
