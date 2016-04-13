lazuli = require "lazuli"

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

  [make_invite_key: "/mik/:username"]: =>
    if @modules.user_management.currentuser
      if config.projectStage=="alpha" and @modules.user_management.currentuser.id==1 or config.projectStage=="beta"
        encode_base64 hmac_sha1 config.secret, @params.username
