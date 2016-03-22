{
  whitelist_globals: {
    ["config.moon"]: {
      "port"
      "password"
      "database"
      "postgres"
      "page_cache_size"
      "code_cache"
      "num_workers"
      "run_daemon"
      "session_name"
      "secret"
      "set"
      "backend"
      "measure_performance"
      "user"
      "host"
      "enable_console"
      "enable_web_migration"
      "modules"
        "user_management"
          "providers"
    }
    ["."]:{ "ngx" }
    ["views%/.+%.moon"]:{
      "html_5"
        "head"
          "meta"
          "link"
          "script"
          "title"
        "body"
          "div","span","section","hr", "ul", "li", "br"
          "h1","h2","h3","h4","h5"
          "form"
            "fieldset", "legend", "input"
            "datalist", "option", "label", "textarea"
          "code"
          "a"
      "text"
      "raw"
      "render"
      "widget"

    }
  }
}
