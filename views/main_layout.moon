html = require "lapis.html"
config = (require "lapis.config").get!
appname=config.appname or "KinkyEureka"

class MainLayout extends html.Widget
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
      body class:"route-"..@route_name..(type(@body_classes)=="string" and " "..@body_classes or ""),->
        render "views.widgets.header"
        div class:"content",->
          @content_for "inner"
