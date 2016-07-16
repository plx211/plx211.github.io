class @AmxxView extends View
  @_generateTable: (name, array) ->
    box = new Box()
    box.add(new BoxHeader().add(new Text(name)))
    boxContent = new BoxContent()
    table = new Table()
    head = new TR()
    head.add(new TH().add(new Text("ID")))
    head.add(new TH().add(new Text("Native")))
    head.add(new TH().add(new Text("Address")))
    head.add(new TH().add(new Text("Nameofs")))
    table.add(head)

    for d, i in array
      head = new TR()
      head.add(new TD().add(new Text("#{i}")))
      head.add(new TD().add(new Text("#{d.name}")))
      head.add(new TD().add(new Text("#{d.address}")))
      head.add(new TD().add(new Text("#{d.nameofs}")))
      table.add(head)

    box.add(boxContent.add(table))

  _generateFileInfo: ->
    text = "
      <div class='row'>
        <div class='col-xs-6 col-md-4'>
          <div class='small-box bg-aqua'>
            <div class='inner'>
              <h3>#{@data.data.raw.length} byte</h3>
              <p>Plugin size</p>
            </div>
          </div>
        </div>

        <div class='col-xs-6 col-md-4'>
          <div class='small-box bg-green'>
            <div class='inner'>
              <h3>#{@data.version32.table.natives.length}</h3>
              <p>Natives count</p>
            </div>
          </div>
        </div>

        <div class='col-xs-6 col-md-4'>
          <div class='small-box bg-yellow'>
            <div class='inner'>
              <h3>#{@data.version32.table.publics.length}</h3>
              <p>Public functions count</p>
            </div>
          </div>
        </div>
      </div>
    "

    @content.add(new Text(text))


  constructor: (plugin) ->
    @name = plugin.name
    @id = plugin.id
    @data = plugin.data
    super(@name, @id)
    @_generateFileInfo()
    @content.add(AmxxView._generateTable("Public functions list", @data.version32.table.publics))
    @content.add(AmxxView._generateTable("Native list", @data.version32.table.natives))
    @content.add(AmxxView._generateTable("Libraries list", @data.version32.table.libraries))
    @content.add(AmxxView._generateTable("Pubvars list", @data.version32.table.pubvars))
    @content.add(AmxxView._generateTable("Tags list", @data.version32.table.tags))
    @show();
