html = require "lapis.html"
markdown = require "markdown" -- lib/lazuli/luarocks install markdown

import getDoMsuffix, formatDate, getAge, blankify_links, strip_html, abbrCaps from require "utils"

class ProfileShow extends html.Widget
  content: =>
    --pre style: "background: rgba(0,0,0,0.8); padding: 1em; margin: 1em;",->
    --  code ->
    --    text require"moonscript.util".dump @profiledata
    div class: "pure-g", ->
      for acl in *@acls
        div class: "pure-u-1-5", acl.id
        div class: "pure-u-3-5", acl.name
        div class: "pure-u-1-5", ->
          unless acl.readonly
            a href: (@url_for "acls_edit", id: acl.id), "Edit"