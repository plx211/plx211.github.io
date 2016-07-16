class @AmxPlugin
  _parseHeader: ->
    @header.size = @data.readUnsignedInt()
    @header.magic = @data.readUnsignedShort()
    @header.file_version = @data.readUnsignedByte()
    @header.amx_version = @data.readUnsignedByte()
    @header.flags = @data.readUnsignedShort()
    @header.defsize = @data.readUnsignedShort()
    @header.cod = @data.readUnsignedInt()
    @header.dat = @data.readUnsignedInt()
    @header.hea = @data.readUnsignedInt()
    @header.stp = @data.readUnsignedInt()
    @header.cip = @data.readUnsignedInt()
    @header.publics = @data.readUnsignedInt()
    @header.natives = @data.readUnsignedInt()
    @header.libraries = @data.readUnsignedInt()
    @header.pubvars = @data.readUnsignedInt()
    @header.tags = @data.readUnsignedInt()
    @header.nametable = @data.readUnsignedInt()
    @header.overlays = @data.readUnsignedInt()

  @_parseTable: (data, start, end, cellSize) ->
    list = {}
    list.array = []
    list.dangerCount = 0
    list.warningCount = 0
    list.unknownCount = 0
    count = (end - start) / cellSize

    data.index = start

    for i in [0...count]
      record =
        address: data.readUnsignedInt()
        nameofs: data.readUnsignedInt()
      list.array.push(record)

    for i in [0...count]
      data.index = list.array[i].nameofs
      name = data.readCString()
      list.array[i].name = name
      list.array[i].danger = BlackList.check(name)
      switch list.array[i].danger
        when "danger" then list.dangerCount++
        when "warning" then list.warningCount++
        when "unknown" then list.unknownCount++

    list

  constructor: (data) ->
    @data = new ByteBuffer(data, ByteBuffer.LITTLE_ENDIAN)
    @header = {}
    @_parseHeader()
    @table =
      publics: AmxPlugin._parseTable(@data, @header.publics, @header.natives, @header.defsize)
      natives: AmxPlugin._parseTable(@data, @header.natives, @header.libraries, @header.defsize)
      libraries: AmxPlugin._parseTable(@data, @header.libraries, @header.pubvars, @header.defsize)
      pubvars: AmxPlugin._parseTable(@data, @header.pubvars, @header.tags, @header.defsize)
      tags: AmxPlugin._parseTable(@data, @header.tags, @header.nametable, @header.defsize)
