html = require "lapis.html"

class ProfileEdit extends html.Widget
  content: =>
    form action:@url_for("profile_edit"), class: "pure-form pure-form-aligned", method:"post", ->
      with @profiledata
        div class: "pure-control-group", ->
          label for: "birthday", "Birthday:"
          input id:"birthday", name:"birthday", type:"date", value: .birthday or ""
        div class: "pure-control-group", ->
          label for: "about", "About me"
          textarea id:"about", name:"about", ->
            raw .about
      div class: "pure-controls", ->
        input type:"submit", class: "pure-button pure-button-primary"