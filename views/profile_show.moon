html = require "lapis.html"
markdown = require "markdown" -- lib/lazuli/luarocks install markdown

config = require"lapis.config".get!

import getDoMsuffix, formatDate, getAge, blankifyLinks, stripHtml, abbrCaps from require "utils"

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
            if .orientation and @acls.orientation
              text " " .. abbrCaps .orientation
            if .preferred_role and @acls.preferred_role
              text " " .. .preferred_role
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
        if .orientation and @acls.orientation
          div class: "pure-u-1-3", "Orientation:"
          div class: "pure-u-2-3", .orientation\lower!
        if .preferred_role and @acls.preferred_role
          div class: "pure-u-1-3", "Preferred role:"
          div class: "pure-u-2-3", .preferred_role
      if .about and @acls.about
        section id:"profile_about", class: "pure-g", ->
          h1 class: "pure-u-1" ,"About me" unless .about\sub(1,2)=="# "
          div class: "pure-u-1", ->
            raw blankifyLinks markdown stripHtml .about
