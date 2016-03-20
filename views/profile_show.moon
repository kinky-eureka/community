html = require "lapis.html"
markdown = require "markdown" -- lib/lazuli/luarocks install markdown

import getDoMsuffix, formatDate, getAge, blankify_links, strip_html from require "utils"

class ProfileShow extends html.Widget
  content: =>
    --pre style: "background: rgba(0,0,0,0.8); padding: 1em; margin: 1em;",->
    --  code ->
    --    text require"moonscript.util".dump @profiledata
    with @profiledata
      section id:"profile_summary", class: "pure-g", ->
        h1 class: "pure-u-1", .user.username
        if .birthday
          if .privacy_birthday_age
            div class: "pure-u-1-3", "Age:"
            div class: "pure-u-2-3", getAge .birthday
          if .privacy_birthday_dm or .privacy_birthday_y
            div class: "pure-u-1-3", "Birthday:"
            div class: "pure-u-2-3", formatDate .birthday, .privacy_birthday_dm, .privacy_birthday_y
      if .about
        section id:"profile_about", class: "pure-g", ->
          h1 class: "pure-u-1" ,"About me"
          div class: "pure-u-1", ->
            raw blankify_links markdown strip_html .about
