html = require "lapis.html"

class ProfileShow extends html.Widget
  content: =>
    code ->
      pre ->
        text require"moonscript.util".dump @profiledata
