html = require "lapis.html"
config = require"lapis.config".get!

class ProfileEdit extends html.Widget
  mkCheck:(name,txt,val)=>
    label for:"c_"..name, class:"pure-checkbox", ->
      input type:"checkbox", id:"c_"..name, :name, checked:(val and "checked" or nil)
      text txt
  acl_options: (sel)=>
    for acl in *@acls
      option value: acl.id, selected:(acl.id==sel and true or nil), acl.name
  content: =>
    if false and config.envmode == "development"
      pre style: "background: rgba(0,0,0,0.8); padding: 1em; margin: 1em;",->
        code ->
          text require"moonscript.util".dump @acls
    form action:@url_for("profile_edit"), class: "pure-form pure-form-stacked", method:"post", ->
      with @profiledata
        fieldset ->
          legend "Birthday"
          input id:"birthday", name:"birthday", type:"date", value: .birthday or ""
          fieldset ->
            legend "Show to:"
            div class: "pure-control-group", ->
              label for: "acl_birthday_dm_id", "Day & Month"
              element "select", name: "acl_birthday_dm_id", id: "acl_birthday_dm_id", -> @acl_options tonumber .acl_birthday_dm_id
              label for: "acl_birthday_y_id", "Year"
              element "select", name: "acl_birthday_y_id", id: "acl_birthday_y_id", -> @acl_options tonumber .acl_birthday_y_id
        fieldset ->
          legend "Gender"
          input id:"gender", name:"gender", type:"text", list:"genderlist", value: .gender or ""
          datalist id:"genderlist", ->
            option value: "Agender"
            option value: "Female"
            option value: "Male"
            option value: "Gender Fluid"
            option value: "Intersex"
          text "Select or type custom, any capitalized letters will be used for abbreviation."
          fieldset ->
            legend "Show to:"
            div class: "pure-control-group", ->
              element "select", name: "acl_gender_id", id: "acl_gender_id", -> @acl_options tonumber .acl_gender_id
        fieldset ->
          legend "About me"
          textarea id:"about", name:"about", ->
            raw .about
          text "This field has "
          a target:"_blank", href:"https://daringfireball.net/projects/markdown/syntax", "markdown support"
          text " but you may not use HTML for security reasons."
          br!
          text "If the first line is a "
          code "# 1st level heading"
          text ", it replaces the \"About me\" heading."
          fieldset ->
            legend "Show to:"
            div class: "pure-control-group", ->
              element "select", name: "acl_about_id", id: "acl_about_id", -> @acl_options tonumber .acl_about_id
      div class: "pure-controls", ->
        input type:"submit", class: "pure-button pure-button-primary"
