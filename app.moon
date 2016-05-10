lazuli = require "lazuli"
import respond_to from require "lapis.application"
import from_json from require "lapis.util"
import hmac_sha1, encode_base64 from require "lapis.util.encoding"
config = (require "lapis.config").get!
Users = require "lazuli.modules.user_management.models.users"

class extends lazuli.Application
  @enable "user_management"

  @include "apps.profile"

  layout: require "views.main_layout"

  handle_404: =>
    status: 404, "Error 404: Failed to find route: #{@req.cmd_url}"

  [index: "/"]: =>
    "This project is in "..config.projectStage.." stage."

  [githubhook: "/githubhook"]: =>
    return status: 400, "no payload" unless @params.payload
    pl=from_json @params.payload
    return status: 400, "broken payload" unless pl
    return status: 200, "wrong branch" unless pl.ref == "refs/heads/deploy" -- should be 428, but then githup fucks up
    require"os".execute "/usr/bin/nohup /bin/zsh ./githubhook.zsh > ./githubhook.log &"
    "ok"

  [android_standalone_home:"/android_standalone_home"]: =>
    @session.android_standalone=true
    if @modules.user_management.currentuser
      return redirect_to: @url_for "profile_show", id: @modules.user_management.currentuser.id
    else
      return redirect_to: @url_for "lazuli_modules_usermanagement_login"

  [make_invite_key: "/make_invite_key/:username"]: =>
    if @modules.user_management.currentuser
      if config.projectStage=="alpha" and @modules.user_management.currentuser.is_admin or config.projectStage=="beta"
        return layout: false, encode_base64 hmac_sha1 config.secret, @params.username

  [make_invite_key_form: "/make_invite_key"]: respond_to {
    GET: =>
      if not @modules.user_management.currentuser
        return redirect_to: @url_for "lazuli_modules_usermanagement_login"
      if config.projectStage~="beta"
        if not (@modules.user_management.currentuser and @modules.user_management.currentuser.is_admin)
          return redirect_to: @url_for "index"
      render: true
    POST: =>
      if not @modules.user_management.currentuser
        return redirect_to: @url_for "lazuli_modules_usermanagement_login"
      if config.projectStage~="beta"
        if not (@modules.user_management.currentuser and @modules.user_management.currentuser.is_admin)
          return redirect_to: @url_for "index"
      @invkey=encode_base64 hmac_sha1 config.secret, @params.username
      render: true
  }

  [find_profile_by_name: "/:name"]: =>
    u = Users\find username: @params.name
    if u and u.id and u.id > 0
      return redirect_to: @url_for "profile_show", id: u.id
    else
      return status: 404, "Error 404: User not found"
