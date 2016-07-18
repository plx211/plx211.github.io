class @BlackList
  @_list: [
    {
      keyword: "SQL_Connect"
      level: "Medium"
    }
    {
      keyword: "set_user_flags"
      level: "High"
    }
    {
      keyword: "download"
      level: "High"
    }
    {
      keyword: "httpdl"
      level: "High"
    }
    {
      keyword: "client_cmd"
      level: "Medium"
    }
    {
      keyword: "amx_sql_host"
      level: "High"
    }
    {
      keyword: "amx_sql_pass"
      level: "High"
    }
    {
      keyword: "rcon_password"
      level: "High"
    }
  ]

  @check: (keyword) ->
    for d, i in BlackList._list
      if d.keyword == keyword
        return d.level
    "Unknown"
