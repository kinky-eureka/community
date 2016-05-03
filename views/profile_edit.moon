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
          legend "Basic info"
          div class: "pure-g", ->
            div class: "pure-u-1-2", ->
              fieldset ->
                legend "Birthday"
                input id:"birthday", name:"birthday", type:"date", value: .birthday or ""
                fieldset ->
                  legend "Show to:"
                  div class: "pure-control-group pure-g", ->
                    div class: "pure-u-1-2", ->
                      label for: "acl_birthday_dm_id", "Day & Month"
                      element "select", name: "acl_birthday_dm_id", id: "acl_birthday_dm_id", -> @acl_options tonumber .acl_birthday_dm_id
                    div class: "pure-u-1-2", ->
                      label for: "acl_birthday_y_id", "Year"
                      element "select", name: "acl_birthday_y_id", id: "acl_birthday_y_id", -> @acl_options tonumber .acl_birthday_y_id
            div class: "pure-u-1-2", ->
              fieldset ->
                legend "Gender"
                input id:"gender", name:"gender", type:"text", list:"genderlist", value: .gender or ""
                datalist id:"genderlist", ->
                  option value: "Agender"
                  option value: "Female"
                  option value: "Gender Fluid"
                  option value: "Intersex"
                  option value: "Male"
                text "Select or type custom, any capitalized letters will be used for abbreviation."
                fieldset ->
                  legend "Show to:"
                  div class: "pure-control-group", ->
                    element "select", name: "acl_gender_id", id: "acl_gender_id", -> @acl_options tonumber .acl_gender_id
            div class: "pure-u-1-2", ->
              fieldset ->
                legend "Orientation"
                input id:"orientation", name:"orientation", type:"text", list:"orientationlist", value: .orientation or ""
                datalist id:"orientationlist", ->
                  option value:"Asexual"
                  option value:"Bisexual"
                  option value:"FLuctuating"
                  option value:"EVOlving"
                  option value:"Straight"
                  option value:"HEteroFLexible"
                  option value:"HOmoFLexible"
                  option value:"Gay"
                  option value:"Lesbian"
                  option value:"Queer"
                  option value:"PANsexual"
                  option value:"Unsure"
                text "Select or type custom, any capitalized letters will be used for abbreviation."
                fieldset ->
                  legend "Show to:"
                  div class: "pure-control-group", ->
                    element "select", name: "acl_orientation_id", id: "acl_orientation_id", -> @acl_options tonumber .acl_orientation_id
            div class: "pure-u-1-2", ->
              fieldset ->
                legend "Preferred role"
                input id:"preferred_role", name:"preferred_role", type:"text", list:"preferred_rolelist", value: .preferred_role or ""
                datalist id:"preferred_rolelist", ->
                  option value:"dominant"
                  option value:"switch"
                  option value:"submissive"
                  option value:"Master"
                  option value:"Mistress"
                  option value:"slave"
                  option value:"Sadist"
                  option value:"Masochist"
                  option value:"Sadomasochist"
                  option value:"Kinkster"
                  option value:"Fetishist"
                  option value:"Swinger"
                  option value:"Hedonist"
                  option value:"Exhibitionist"
                  option value:"Voyeur"
                  option value:"Sensualist"
                  option value:"Princess"
                  option value:"Slut"
                  option value:"Doll"
                  option value:"Rigger"
                  option value:"Rope Top"
                  option value:"Rope Bottom"
                  option value:"Rope Bunny"
                  option value:"Spanker"
                  option value:"Spankee"
                  option value:"Furry"
                  option value:"Primal"
                  option value:"Primal Predator"
                  option value:"Primal Prey"
                  option value:"Daddy"
                  option value:"Mommy"
                  option value:"little"
                  option value:"brat"
                  option value:"babygirl"
                  option value:"babyboy"
                  option value:"pet"
                  option value:"kitten"
                  option value:"pup"
                  option value:"pony"
                  option value:"Evolving"
                  option value:"Exploring"
                  option value:"Vanilla"
                  option value:"Undecided"
                text "Select or type custom."
                fieldset ->
                  legend "Show to:"
                  div class: "pure-control-group", ->
                    element "select", name: "acl_preferred_role_id", id: "acl_preferred_role_id", -> @acl_options tonumber .acl_preferred_role_id

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
