html = require "lapis.html"

class ProfileShow extends html.Widget
  content: =>
    --pre style: "background: rgba(0,0,0,0.8); padding: 1em; margin: 1em;",->
    --  code ->
    --    text require"moonscript.util".dump @profiledata
    with @profiledata
      section id:"profile_summary", class: "pure-g", ->
        h1 class: "pure-u-1", .user.username
        if .birthday
          div class: "pure-u-1-3", "Birthday:"
          div class: "pure-u-2-3", .birthday
      if .about
        section id:"profile_about", class: "pure-g", ->
          h1 class: "pure-u-1" ,"About me"
          div class: "pure-u-1", .about
