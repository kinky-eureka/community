import Widget from require "lapis.html"
import escape from require "lapis.util"
class extends Widget
  content: =>
    if @invkey
      h1 "Invite key created"
      img style: "display: block; margin: 10px auto;width: 300px", src: "https://chart.googleapis.com/chart?chs=300x300&cht=qr&chld=M|3&choe=UTF-8&chl="..escape("http://kinky-eureka.com/users/register?uname="..@params.username.."&key="..@invkey)
      text "Give the following key to the person who wants to register as "
      b style: "background: rgba(0,0,0,0.8); padding: 2px;", @params.username
      text ":"
      pre style: "background: rgba(0,0,0,0.8); padding: 1em; margin: 1em; text-align: center;",->
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
