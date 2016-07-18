class @AmxView
  @renderMenu: (name, id) ->
    $.get("./template/menu_position.mst", (template) ->
      $("#menu").append(Handlebars.compile(template)({name, id}))
    , 'text')

  @renderContent: (name, id, plugin) ->
    $.get("./template/amx_content.mst", (template) ->
      $("#content").append(Handlebars.compile(template)({name, id, plugin}))
    , 'text')

  @renderPlugin: (name, id, plugin) ->
    AmxView.renderMenu(name, id)
    AmxView.renderContent(name, id, plugin)
