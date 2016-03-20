lazuli = require "lazuli"
Profiles = require "models.profiles"
import respond_to from require "lapis.application"


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

  [edit: "/edit"]: respond_to {
    GET: =>
      if @modules.user_management.currentuser
        @profiledata,err=Profiles\getOrCreateByUser @modules.user_management.currentuser
        return render: true
      else
        @session.login_redirect=@req.parsed_url.path
        return redirect_to: @url_for "lazuli_modules_usermanagement_login"
    POST: =>
      if @modules.user_management.currentuser
        @profiledata,err=Profiles\getOrCreateByUser @modules.user_management.currentuser
        @profiledata\update{
          about: @params.about
          birthday: @params.birthday
          privacy_birthday_dm: @params.privacy_birthday_dm or false
          privacy_birthday_y: @params.privacy_birthday_y or false
          privacy_birthday_age: @params.privacy_birthday_age or false
          gender: @params.gender
          privacy_gender: @params.privacy_gender or false
        }
        return render: true
      else
        @session.login_redirect=@req.parsed_url.path
        return redirect_to: @url_for "lazuli_modules_usermanagement_login"
  }