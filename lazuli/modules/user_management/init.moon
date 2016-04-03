UsersApplication=require "lib.lazuli.src.lazuli.modules.user_management"
Profiles = require "models.profiles"
ACLs = require "models.acls"
ACL_Entries = require "models.acl_entries"

prepareUserProfile=(user)->
  profile=Profiles\getOrCreateByUser user
  nobodyACL=ACLs\create {
    user_id: user.id
    name: "nobody"
    default_policy: false
    readonly: true
  }
  everyoneACL=ACLs\create {
    user_id: user.id
    name: "everyone"
    default_policy: true
    readonly: true
  }
  usersACL=ACLs\create {
    user_id: user.id
    name: "logged in users"
    default_policy: false
    readonly: true
  }
  ACL_Entries\create {
    acl_id: usersACL.id
    target_type: ACL_Entries.target_types.include
    target_id: ACL_Entries.special_targets.include_logged_in
    policy: true
  }
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
