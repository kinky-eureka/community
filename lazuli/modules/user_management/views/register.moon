import Widget from require "lapis.html"
config = (require "lapis.config").get!

class RegisterWithKey extends Widget
  content: =>
    h1 "Register account"
    form action: @url_for("lazuli_modules_usermanagement_register_do"), method: "post", class: "pure-form pure-form-aligned", ->
      input type: "hidden", name: "csrf_token", value: @modules.user_management.csrf_token
      fieldset ->
        div class: "pure-control-group", ->
          label for: "username", "Username:"
          input id: "username",name: "username"
        div class: "pure-control-group", ->
          label for: "password", "Password:"
          input id: "password", type: "password", name: "password"
        div class: "pure-control-group", ->
          label for: "password_repeat", "Repeat:"
          input id: "password_repeat", type: "password",name: "password_repeat"
        if config.projectStage=="alpha" or config.projectStage=="beta"
          div class: "pure-control-group", ->
            label for: "key", "Invitation Key ("..config.projectStage.."):"
            input id: "key", name: "key", value: @params.key or ""
        div class: "pure-controls", ->
          input type: "submit", class: "pure-button pure-button-primary"
