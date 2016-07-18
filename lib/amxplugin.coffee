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

  @_parseTable: (name, data, start, end, cellSize) ->
    list = {}
    list.array = []
    list.name = name
    list.dangerCount = {}
    list.dangerCount.high = 0
    list.dangerCount.medium = 0
    list.dangerCount.unknown = 0

    count = (end - start) / cellSize

    data.index = start

    for i in [0...count]
      record =
        address: data.readUnsignedInt()
        nameofs: data.readUnsignedInt()
      list.array.push(record)

    for d, i in list.array
      data.index = d.nameofs
      name = data.readCString()
      d.name = name
      d.danger = BlackList.check(name)
      switch d.danger
        when "high" then list.dangerCount.high++
        when "medium" then list.dangerCount.medium++
        when "unknown" then list.dangerCount.unknown++

    return list

  constructor: (data) ->
    @data = new ByteBuffer(data, ByteBuffer.LITTLE_ENDIAN)
    @hash = md5(data)
    @header = {}
    @_parseHeader()
    @table =
      publics: AmxPlugin._parseTable("Publics function", @data, @header.publics, @header.natives, @header.defsize)
      natives: AmxPlugin._parseTable("Natives", @data, @header.natives, @header.libraries, @header.defsize)
      libraries: AmxPlugin._parseTable("Libraries", @data, @header.libraries, @header.pubvars, @header.defsize)
      pubvars: AmxPlugin._parseTable("Pubvars", @data, @header.pubvars, @header.tags, @header.defsize)
      tags: AmxPlugin._parseTable("Tags", @data, @header.tags, @header.nametable, @header.defsize)
