html = require "lapis.html"
markdown = require "markdown" -- lib/lazuli/luarocks install markdown

months={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"}

formatBirthday=(ymdstr,_dm,_y)->
  y,m,d=ymdstr\match "(%d%d%d%d)-(%d%d?)-(%d%d?)"
  (_dm and d..". "..months[tonumber m] or "")..(_dm and _y and " " or "")..(_y and y or "")

getAge=(ymdstr)->
  y,m,d=ymdstr\match "(%d%d%d%d)-(%d%d?)-(%d%d?)"
  span=os.time()-os.time{year:y,month:m,day:d}
  (tonumber(os.date("%Y", span)) - 1970)

blankify_links=(htmlstr)->
  (htmlstr\gsub "<a href", "<a target=\"_blank\" href")

class ProfileShow extends html.Widget
  content: =>
    --pre style: "background: rgba(0,0,0,0.8); padding: 1em; margin: 1em;",->
    --  code ->
    --    text require"moonscript.util".dump @profiledata
    with @profiledata
      section id:"profile_summary", class: "pure-g", ->
        h1 class: "pure-u-1", .user.username
        if .birthday
          if .privacy_birthday_age
            div class: "pure-u-1-3", "Age:"
            div class: "pure-u-2-3", getAge .birthday
          if .privacy_birthday_dm or .privacy_birthday_y
            div class: "pure-u-1-3", "Birthday:"
            div class: "pure-u-2-3", formatBirthday .birthday, .privacy_birthday_dm, .privacy_birthday_y
      if .about
        section id:"profile_about", class: "pure-g", ->
          h1 class: "pure-u-1" ,"About me"
          div class: "pure-u-1", ->
            raw blankify_links markdown .about\gsub("<[A-Za-z/!$][A-Za-z/!$ %-%_\"]*>", "")
