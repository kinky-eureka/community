lazuli = require "lazuli"
Profiles = require "models.profiles"
ACLs = require "models.acls"
import respond_to from require "lapis.application"

import NULL from require "lapis.db"

class extends lazuli.Application
  @enable "user_management"

  @name: "profile_"
  @path: "/profile"

  [show: "/:id[%d]"]: =>
    @profiledata,err=Profiles\getOrCreateByUser tonumber @params.id
    if @profiledata
      @acls={
        gender:      @profiledata.acl_gender_id>0      and @profiledata\get_acl_gender!\matchUser      @modules.user_management.currentuser
        birthday_y:  @profiledata.acl_birthday_y_id>0  and @profiledata\get_acl_birthday_y!\matchUser  @modules.user_management.currentuser
        birthday_dm: @profiledata.acl_birthday_dm_id>0 and @profiledata\get_acl_birthday_dm!\matchUser @modules.user_management.currentuser
        about:       @profiledata.acl_about_id>0       and @profiledata\get_acl_about!\matchUser       @modules.user_management.currentuser
      }
      return render: true
    else
      return status: 404, "Error 404: "..err

  [edit: "/edit"]: respond_to {
    GET: =>
      if @modules.user_management.currentuser
        @profiledata,err=Profiles\getOrCreateByUser @modules.user_management.currentuser
        @acls=ACLs\select "where user_id=?", @modules.user_management.currentuser.id
        return render: true
      else
        @session.login_redirect=@req.parsed_url.path
        return redirect_to: @url_for "lazuli_modules_usermanagement_login"
    POST: =>
      if @modules.user_management.currentuser
        @acls=ACLs\select "where user_id=?", @modules.user_management.currentuser.id
        @profiledata,err=Profiles\getOrCreateByUser @modules.user_management.currentuser
        @profiledata\update{
          about: @params.about or NULL
          birthday: @params.birthday\find"%d%d%d%d-%d%d?-%d%d?" and @params.birthday or NULL
          gender: @params.gender or NULL
          acl_gender_id: @params.acl_gender_id or NULL
          acl_birthday_y_id: @params.acl_birthday_y_id or NULL
          acl_birthday_dm_id: @params.acl_birthday_dm_id or NULL
          acl_about_id: @params.acl_about_id or NULL
        }
        return render: true
      else
        @session.login_redirect=@req.parsed_url.path
        return redirect_to: @url_for "lazuli_modules_usermanagement_login"
  }
