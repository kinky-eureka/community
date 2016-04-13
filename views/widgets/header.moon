html = require "lapis.html"
config = (require "lapis.config").get!
appname=config.appname or "KinkyEureka"

class Header extends html.Widget
  @include "lazuli.modules.user_management.views.mixin_menu"
  header_item:(act,txt,...)=>
    url=@url_for(act,...)
    selcl=(@req.parsed_url.path==url and " pure-menu-selected" or "")
    li class:"pure-menu-item"..selcl,-> a href:url, class:"pure-menu-link",txt
  content: =>
    div class:"header",->
      div class:"pure-menu pure-menu-horizontal",->
        a href:@url_for"index", class:"pure-menu-heading pure-menu-link", appname
        ul class:"pure-menu-list",->
        if @modules.user_management.currentuser
          ul class:"pure-menu-list usermenu",->
            url=@url_for("profile_show",id: @modules.user_management.currentuser.id)
            li class: (
                        "own_profile_link pure-menu-has-children pure-menu-allow-hover pure-menu-item"..
                        (@req.parsed_url.path==url and " pure-menu-selected" or "")
                      ), ->
              a href: url, class: "pure-menu-link", @modules.user_management.currentuser.username
              ul class: "pure-menu-children", ->
                @header_item "profile_edit", "Edit profile"
                if config.projectStage=="beta"
                  @header_item "make_invite_key_form", "Create invite key!"
                @header_item "lazuli_modules_usermanagement_logout", "Logout"
        else
          @userManagementMixinMenu!
