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

  @addPlugin: (data, type) ->
    switch type
      when "amxx" then PluginManager._addAmxxPlugin(new AmxxPlugin(data))
      when "amx" then PluginManager._addAmxPlugin(data)
      else throw error
