import Widget from require "lapis.html"

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
        div class: "pure-control-group", ->
          label for: "key", "Invitation Key:"
          input id: "key", name: "key"
        div class: "pure-controls", ->
          input type: "submit", class: "pure-button pure-button-primary"
