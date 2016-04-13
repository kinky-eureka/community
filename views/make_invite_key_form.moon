import Widget from require "lapis.html"

class extends Widget
  content: =>
    if @invkey
      h1 "Invite key created"
      text "Give the following key to the person who wants to register as "
      b style: "background: rgba(0,0,0,0.8); padding: 2px;", @params.username
      text ":"
      pre style: "background: rgba(0,0,0,0.8); padding: 1em; margin: 1em;",->
        code ->
          text @invkey
      h2 "Create another"
    else
      h1 "Create invite key"
    form action: @url_for("make_invite_key_form"), method: "post", class: "pure-form pure-form-aligned", ->
      fieldset ->
        div class: "pure-control-group", ->
          label for: "username", "Nick name:"
          input id: "username",name: "username", value: @params.username or ""
          text " they'll have to register using this name."
        div class: "pure-controls", ->
          input type: "submit", class: "pure-button pure-button-primary"
