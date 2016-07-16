class @View
  show: ->
    console.log(this)
    $("#menu").append(@menu.parse())
    $("#content").append(@content.parse())
    $.AdminLTE.layout.fix()

  constructor: (name, id) ->
    @menu  = new MenuPosition(name, id)
    @content = new Site(name, id)
