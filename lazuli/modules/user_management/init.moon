UsersApplication=require "lib.lazuli.src.lazuli.modules.user_management"
Profiles = require "models.profiles"

prepareUserProfile=(user)->
  profile=Profiles\getOrCreateByUser user
  -- TODO: default ACLs, etc.



class CustomUsersApplication extends UsersApplication
  @superroute logout: "/logout"
  @superroute login: "/login"
  @superroute register: "/register"
  @superroute register_do: "/register/do", (ret)=>
    if (ret.status ~= 403) and @modules.user_management.currentuser
      prepareUserProfile @modules.user_management.currentuser
    ret
  @superroute login_do: "/login/do", (ret)=>
    if @modules.user_management.currentuser
      if @session.login_redirect
        red=@session.login_redirect
        @session.login_redirect=nil
        redirect_to: red
      else
        redirect_to: @url_for "profile_show", id: @modules.user_management.currentuser.id
    else
      ret
