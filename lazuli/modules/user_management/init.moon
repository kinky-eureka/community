import hmac_sha1, encode_base64 from require "lapis.util.encoding"
UsersApplication=require "lib.lazuli.src.lazuli.modules.user_management"
Profiles = require "models.profiles"
ACLs = require "models.acls"
ACL_Entries = require "models.acl_entries"
config = (require "lapis.config").get!
csrf = require "lapis.csrf"

prepareUserProfile=(user)->
  profile=Profiles\getOrCreateByUser user
  nobodyACL=ACLs\create {
    user_id: user.id
    name: "nobody"
    default_policy: false
  }
  everyoneACL=ACLs\create {
    user_id: user.id
    name: "everyone"
    default_policy: true
  }
  usersACL=ACLs\create {
    user_id: user.id
    name: "logged in users"
    default_policy: false
  }
  ACL_Entries\create {
    acl_id: usersACL.id
    target_type: ACL_Entries.target_types.include
    target_id: ACL_Entries.special_targets.include_logged_in
    policy: true
  }
  -- TODO: default ACLs, etc.



class CustomUsersApplication extends UsersApplication
  @before_filter =>
    if config.projectStage=="alpha" or config.projectStage=="beta"
      if @req.parsed_url.path=="/users/register/do" and @req.params_post.key~=encode_base64 hmac_sha1 config.secret, @req.params_post.username
        @write redirect_to: @url_for "index"
    @modules.user_management or={}
    @session.modules.user_management or={}
    if not @modules.user_management.providers
      if type(config.modules.user_management)=="table" and type(config.modules.user_management.providers)=="table"
        @modules.user_management.providers={k,require(k)(@,k,v) for k,v in pairs config.modules.user_management.providers}
      else
        @modules.user_management.providers={}
    @modules.user_management.csrf_token = csrf.generate_token @, "lazuli_modules_usermanagement"
    if @session.modules.user_management.currentuser and not @modules.user_management.currentuser
      @modules.user_management.currentuser = Users\find @session.modules.user_management.currentuser
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
