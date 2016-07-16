class @AmxxPlugin
  _parseHeader: ->
    @header.magic = @data.readUnsignedInt()
    @header.version = @data.readUnsignedShort()
    @header.sections = @data.readUnsignedByte()
    @header.cellsize = @data.readUnsignedByte()
    @header.disksize = @data.readUnsignedInt()
    @header.imagesize = @data.readUnsignedInt()
    @header.memsize = @data.readUnsignedInt()
    @header.offs = @data.readUnsignedInt()

  _parseVersion32: ->
    @data.index = @header.offs
    @rawVersion32 = @data.read(@header.disksize)
    uncompresseData = pako.inflate(@rawVersion32.buffer)
    @version32 = new AmxPlugin(uncompresseData)

  _parseVersion64: ->
    @data.index = @header.offs + @header.disksize
    @rawVersion64 = @data.read()
    uncompresseData = pako.inflate(@rawVersion64.buffer)
    @version64 = new AmxPlugin(uncompresseData)


  constructor: (data) ->
    @data = new ByteBuffer(data, ByteBuffer.LITTLE_ENDIAN)
    @header = {}
    @rawVersion32 = {}
    @rawVersion64 = {}
    @version32 = {}
    @version64 = {}
    @hash = md5(data)
    @_parseHeader()
    @_parseVersion32()
    #@_parseVersion64()
