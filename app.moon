lazuli = require "lazuli"

class extends lazuli.Application
  @enable "user_management"

  @include "apps.profile"
  @include "apps.acls"

  layout: require "views.main_layout"

  handle_404: =>
    status: 404, "Error 404: Failed to find route: #{@req.cmd_url}"

  [index: "/"]: =>
    "WIP!"
