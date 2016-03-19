html = require "lapis.html"
config = (require "lapis.config").get!
appname=config.appname or "l0g1n.de"

class MainLayout extends html.Widget
  @include "views.mixin.header"
  --@include "views.mixin.favicon"
  @include "lazuli.modules.user_management.views.mixin_menu"
  content: =>
    html_5 ->
      head ->
        meta charset:"utf-8"
        meta name:"viewport", content:"width=device-width, initial-scale=1"
        link rel:"stylesheet", href:"/static/css/pure-min.css"
        link rel:"stylesheet", href:"/static/css/main_layout.less.css"
        script src:"/static/js/jquery.min.js"
        script src:"/static/js/dropdownmenu.js"
        title (
          (@title and @title.." - "..appname) or
          (@has_content_for("title") and @content_for("title").." - "..appname) or
          appname
        )
        --@mixFavicon!
      body class:"route-"..@route_name..(type(@body_classes)=="string" and " "..@body_classes or ""),->
        @mixin_header!
        div class:"content",->
          @content_for "inner"
