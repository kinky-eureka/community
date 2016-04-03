lazuli = require "lazuli"
ACLs = require "models.acls"
ACL_Entries = require "models.acl_entries"
import respond_to from require "lapis.application"

import NULL from require "lapis.db"

class extends lazuli.Application
  @enable "user_management"

  @name: "acls_"
  @path: "/acls"

  [list: ""]: =>
    if @modules.user_management.currentuser
      @acls=ACLs\select user_id: @modules.user_management.currentuser.id
      return render: true
    else
      @session.login_redirect=@req.parsed_url.path
      return redirect_to: @url_for "lazuli_modules_usermanagement_login"

  [edit: "/edit/:id[%d]"]: respond_to {
    GET: =>
      if @modules.user_management.currentuser
        @acl=ACLs\find tonumber @params.id
        return status: 403 unless @modules.user_management.currentuser.id == @acl.user_id
        @entries=ACL_Entries\select acl_id: @acl.id
        return render: true
      else
        @session.login_redirect=@req.parsed_url.path
        return redirect_to: @url_for "lazuli_modules_usermanagement_login"
    POST: =>
      -- todo
  }
