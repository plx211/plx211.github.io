class @BlackList
  @_list: [
    {
      keyword: "SQL_Connect"
      level: "warning"
    }
    {
      keyword: "set_user_flags"
      level: "danger"
    }
    {
      keyword: "download"
      level: "danger"
    }
    {
      keyword: "httpdl"
      level: "danger"
    }
    {
      keyword: "client_cmd"
      level: "warning"
    }
    {
      keyword: "amx_sql_host"
      level: "danger"
    }
    {
      keyword: "amx_sql_pass"
      level: "danger"
    }
    {
      keyword: "rcon_password"
      level: "danger"
    }
  ]

  @check: (keyword) ->
    for d, i in BlackList._list
      if d.keyword == keyword
        return d.level
    "unknown"
