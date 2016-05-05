html = require "lapis.html"
config = (require "lapis.config").get!
appname=config.appname or "KinkyEureka"

import staticUrl from require "utils"

class MainLayout extends html.Widget
  content: =>
   html_5 ->
      head ->
        meta charset:"utf-8"
        meta name:"viewport", content:"width=device-width, initial-scale=1"
        link rel:"stylesheet", href: staticUrl"/css/pure-min.css"
        link rel:"stylesheet", href: staticUrl"/css/main_layout.less.css"
        render "views.widgets.favicon"
        script src: staticUrl"/js/jquery.min.js"
        script src: staticUrl"/js/dropdownmenu.js"
        title (
          (@title and @title.." - "..appname) or
          (@has_content_for("title") and @content_for("title").." - "..appname) or
          appname
        )
      body class:"route-"..@route_name..(type(@body_classes)=="string" and " "..@body_classes or ""),->
        render "views.widgets.header"
        div class:"content",->
          @content_for "inner"
