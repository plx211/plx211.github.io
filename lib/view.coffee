class @View
  @render: -> (id, name, data)
  show: ->
    $("#menu").append(@generateMenu())
    $("#content").append(@generateContent())
    $.AdminLTE.layout.fix()

  generateMenu: ->
    View.getTemplate("./template/menu_position.mst", @data)

  generateContent: ->
    View.getTemplate("./template/content.mst", @data)

  @getTemplate: (templatePath, data) ->
    result = ""
    $.ajaxSetup( { "async": false } );
    $.get(templatePath, (template) ->
      result = Mustache.render(template, data)
    , 'text')
    return result

  constructor: (name, id) ->
    @template =
      menu: "./template/menu_position.mst"
      content: "./template/content.mst"

    @menuData = {name, id}
    @contentData = {name, id}
