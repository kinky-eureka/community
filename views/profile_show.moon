html = require "lapis.html"
markdown = require "markdown" -- lib/lazuli/luarocks install markdown

config = require"lapis.config".get!

import getDoMsuffix, formatDate, getAge, blankify_links, strip_html, abbrCaps from require "utils"

class ProfileShow extends html.Widget
  content: =>
    if false and config.envmode == "development"
      pre style: "background: rgba(0,0,0,0.8); padding: 1em; margin: 1em;",->
        code ->
          text require"moonscript.util".dump @profiledata
    with @profiledata
      section id:"profile_summary", class: "pure-g", ->
        h1 class: "pure-u-1", ->
          text \get_user!.username
          span class: "shortInfo", ->
            if .birthday and @acls.birthday_y
              text getAge .birthday
            if .gender and @acls.gender
              text abbrCaps .gender
        if .gender and @acls.gender
          div class: "pure-u-1-3", "Gender:"
          div class: "pure-u-2-3", .gender\lower!
        if .birthday
          if @acls.birthday_y
            div class: "pure-u-1-3", "Age:"
            div class: "pure-u-2-3", getAge .birthday
          if @acls.birthday_dm or @acls.birthday_y
            div class: "pure-u-1-3", "Birthday:"
            div class: "pure-u-2-3", formatDate .birthday, @acls.birthday_dm, @acls.birthday_y
      if .about and @acls.about
        section id:"profile_about", class: "pure-g", ->
          h1 class: "pure-u-1" ,"About me" unless .about\sub(1,2)=="# "
          div class: "pure-u-1", ->
            raw blankify_links markdown strip_html .about
