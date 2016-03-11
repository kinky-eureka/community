UsersApplication=require "lib.lazuli.src.lazuli.modules.user_management"

class CustomUsersApplication extends UsersApplication
  @superroute logout: "/logout"
  @superroute login: "/login"
  @superroute register: "/register"
  @superroute register_do: "/register/do"
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
