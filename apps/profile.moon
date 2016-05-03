lazuli = require "lazuli"
Profiles = require "models.profiles"
ACLs = require "models.acls"
import respond_to from require "lapis.application"

import NULL from require "lapis.db"

matchProfileAcl = (p,u,name)->
  if p["acl_"..name.."_id"] and p["acl_"..name.."_id"]>0
    acl=p["get_acl_"..name] p
    return acl and acl\matchUser u
  return false


class extends lazuli.Application
  @enable "user_management"

  @name: "profile_"
  @path: "/profile"

  [show: "/:id[%d]"]: =>
    @profiledata,err=Profiles\getOrCreateByUser tonumber @params.id
    if @profiledata
      @acls={i, matchProfileAcl @profiledata, @modules.user_management.currentuser, i for i in *{
        "gender", "birthday_y", "birthday_dm", "about", "orientation", "preferred_role"
      }}
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
          orientation: @params.orientation or NULL
          preferred_role: @params.preferred_role or NULL
          acl_gender_id: @params.acl_gender_id or NULL
          acl_birthday_y_id: @params.acl_birthday_y_id or NULL
          acl_birthday_dm_id: @params.acl_birthday_dm_id or NULL
          acl_about_id: @params.acl_about_id or NULL
          acl_orientation_id: @params.acl_orientation_id or NULL
          acl_preferred_role_id: @params.acl_preferred_role_id or NULL
        }
        return render: true
      else
        @session.login_redirect=@req.parsed_url.path
        return redirect_to: @url_for "lazuli_modules_usermanagement_login"
  }
