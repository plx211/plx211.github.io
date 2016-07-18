class @PluginManager
  @_plugins:
    array: []
    count: 0

  @_generateRandomStr: ->
    (Math.random()*1e32).toString(36)

  @_addAmxxPlugin: (plugin) ->
    count = ++PluginManager._plugins.count
    data =
      name: $("#plugin_name").val()
      id: "amxx-#{count}"
      plugin: plugin
    console.log(data)

    $.get("./template/amxx/menu_position.mst", (template) ->
      rendered = Mustache.render(template, data)
      $('#menu').append(rendered)
    , 'text')

    $.get("./template/amxx/content.mst", (template) ->
      rendered = Mustache.render(template, data)
      $('#content').append(rendered)
    , 'text')

    $.AdminLTE.layout.fix()


  @_addAmxPlugin: (data) ->

  @addPlugin: (plugin, type) ->
    count = ++PluginManager._plugins.count
    data =
      name: $("#plugin_name").val()
      id: "amxx-#{count}"
      plugin: new AmxxPlugin(plugin)

    view = {}

    switch type
      when "amxx" then AmxxView.renderPlugin(data.name, data.id, data.plugin)
      when "amx" then view = new AmxView(data.name, data.id, data.plugin)
      else throw error
