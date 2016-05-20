--copy this file to custom_config.moon to set secrets

import config from require "lazuli.config"


config {"development","test","production"},->
  set "appname", "KinkyEureka"
  set "projectStage", "alpha"
  --set "projectStage", "beta"
  --set "projectStage", "1.0"

config {"development","test"}, ->
  postgres ->
    database "<EDIT THIS>"
    password "<EDIT THIS>"
  session_name "<EDIT THIS>"
  secret "<EDIT THIS>"
  port 8080
  acl_cache_size "1m"
  timeline_cache_size "1m"
  static_url_prefix "/static"
  modules ->
    user_management ->
      providers ->
        --set "lazuli.modules.user_management.providers.example_false", true

config "production", ->
  postgres ->
    database "<EDIT THIS>"
    password "<EDIT THIS>"
  port 8081 -- EDIT THIS
  page_cache_size "10m"
  acl_cache_size "5m"
  timeline_cache_size "5m"
  static_url_prefix "/static"
  session_name "<EDIT THIS>"
  secret "<EDIT THIS>"
