class @Form
  parse: ->
    text = "<#{@tag} class='#{@class}'>"

    for d, i in @inside
      text += d.parse()

    text += "</#{@tag}>"

  add: (form) ->
    @inside.push(form)
    @

  constructor: ->
    @tag = ""
    @class = ""
    @inside = []

class @MenuPosition
  parse: ->
    "<li>
      <a data-toggle='tab' href='##{@id}'>
        #{@name}
      </a>
    </li>"

  constructor: (name, id) ->
    @name = name
    @id = id

class @Site extends Form
  parse: ->
    text = ""

    for d, i in @inside
      text += d.parse()

    "<div id='#{@id}' class='tab-pane fade'>
      <div class='content-wrapper'>
        <section class='content-header'>
          <h1>#{@name}</h1>
        </section>
        <section class='content'>
          #{text}
        </section>
      </div>
    </div>"

  constructor: (name, id) ->
    super
    @name = name
    @id = id

class @Text
  parse: ->
    @content

  constructor: (content) ->
    @content = content

class @Div extends Form
  constructor: ->
    super
    @tag = "div"

class @Table extends Form
  constructor: ->
    super
    @tag = "table"
    @class = "table table-bordered"

class @TH extends Form
  constructor: ->
    super
    @tag = "th"

class @TD extends Form
  constructor: ->
    super
    @tag = "td"

class @TR extends Form
  constructor: ->
    super
    @tag = "tr"

class @Box extends Div
  constructor: ->
    super
    @class = "box"

class @BoxHeader extends Div
  constructor: ->
    super
    @class = "box-header with-border"

class @BoxContent extends Div
  constructor: ->
    super
    @class = "box-body"
