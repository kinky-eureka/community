html = require "lapis.html"
config = (require "lapis.config").get!
appname=config.appname or "KinkyEureka"

class MixinHeader extends html.Widget
  _mixin_header_item:(act,txt,...)=>
    url=@url_for(act,...)
    selcl=(@req.parsed_url.path==url and " pure-menu-selected" or "")
    li class:"pure-menu-item"..selcl,-> a href:url, class:"pure-menu-link",txt
  mixin_header: =>
    div class:"header",->
      div class:"pure-menu pure-menu-horizontal",->
        a href:@url_for"index", class:"pure-menu-heading pure-menu-link", appname
        ul class:"pure-menu-list",->
        @userManagementMixinMenu!
