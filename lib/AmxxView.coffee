class @AmxxView
  @renderMenu: (name, id) ->
    $.get("./template/amxx_menu.mst", (template) ->
      $("#menu").append(Handlebars.compile(template)({name, id}))
    , 'text')

  @renderContent: (name, id, plugin) ->
    amxVer32 =
      name: "#{name} - Version 32"
      id: "#{id}-ver32"
      plugin: plugin.version32

    $.get("./template/amxx_content.mst", (template) ->
      $("#content").append(Handlebars.compile(template)({name, id, plugin}))
    , 'text')

    $.get("./template/amx_content.mst", (template) ->
      $("#content").append(Handlebars.compile(template)(amxVer32))
    , 'text')

  @renderPlugin: (name, id, plugin) ->
    AmxxView.renderMenu(name, id)
    AmxxView.renderContent(name, id, plugin)
