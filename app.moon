lazuli = require "lazuli"
import respond_to from require "lapis.application"
import from_json from require "lapis.util"
import hmac_sha1, encode_base64 from require "lapis.util.encoding"
config = (require "lapis.config").get!

class extends lazuli.Application
  @enable "user_management"

  @include "apps.profile"

  layout: require "views.main_layout"

  handle_404: =>
    status: 404, "Error 404: Failed to find route: #{@req.cmd_url}"

  [index: "/"]: =>
    "WIP!"

  [githubhook: "/githubhook"]: =>
    return status: 400, "no payload" unless @params.payload
    pl=from_json @params.payload
    return status: 400, "broken payload" unless pl
    return status: 428, "wrong branch" unless pl.ref == "refs/heads/deploy"
    require"os".execute "/bin/zsh /githubhook.sh &"

  [make_invite_key: "/mik/:username"]: =>
    if @modules.user_management.currentuser
      if config.projectStage=="alpha" and @modules.user_management.currentuser.id==1 or config.projectStage=="beta"
        return layout: false, encode_base64 hmac_sha1 config.secret, @params.username

  [make_invite_key_form: "/mik"]: respond_to {
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
