import config from require "lazuli.config"


config {"development","test","production"},->
  set "appname", "KinkyEureka"

config {"development","test"}, ->
  postgres ->
    database "<EDIT THIS>"
    password "<EDIT THIS>"
  session_name "<EDIT THIS>"
  secret "<EDIT THIS>"
  port 8080
  modules ->
    user_management ->
      providers ->
        --set "lazuli.modules.user_management.providers.example_false", true

config "production", ->
  postgres ->
    database "<EDIT THIS>"
    password "<EDIT THIS>"
  port 8081 -- EDIT THIS
  session_name "<EDIT THIS>"
  secret "<EDIT THIS>"
