html = require "lapis.html"

class ProfileEdit extends html.Widget
  mkCheck:(name,txt,val)=>
    label for:"c_"..name, class:"pure-checkbox", ->
      input type:"checkbox", id:"c_"..name, :name, checked:(val and "checked" or nil)
      text txt
  content: =>
    form action:@url_for("profile_edit"), class: "pure-form pure-form-stacked", method:"post", ->
      with @profiledata
        fieldset ->
          legend "Birthday"
          input id:"birthday", name:"birthday", type:"date", value: .birthday or ""
          fieldset ->
            legend "Show:"
            div class: "pure-control-group", ->
              @mkCheck "privacy_birthday_dm", "Date & Month", .privacy_birthday_dm
              @mkCheck "privacy_birthday_y", "Year", .privacy_birthday_y
              @mkCheck "privacy_birthday_age", "Age in years", .privacy_birthday_age
        fieldset ->
          legend "About me"
          textarea id:"about", name:"about", ->
            raw .about
      div class: "pure-controls", ->
        input type:"submit", class: "pure-button pure-button-primary"