Artnet = require('artnet')

module.exports = class DmxManager extends Marionette.Object

  # --------------------------------------------
  # start config

  host: '127.0.0.1'

  devices: [
    'ledBar001',
    'adjRevo001',
    'adjQuadPhase001',
  ]

  # end config
  # --------------------------------------------

  env:                null
  dmxOutoutArray:     null
  dmxOutputInterval:  null

  initialize: (options) =>
    @env            = options.env
    @dmxOutoutArray = []

    @updateDmxOutputArray()
    @_startDmxWriteInterval()

  updateDmxOutputArray: =>
    index = 0
    data  = null

    _.each @devices, (deviceName) =>
      device  = @env.getDevice(deviceName)
      data    = device.getData()

      _.times device.getChannelsCount(), (i) =>
        @dmxOutoutArray[index] = data[i]
        index += 1

  getArtnet: =>
    @_artnet or= Artnet({ host: @host })

  # ---------------------------------------------
  # private methods

  # @nodoc
  _startDmxWriteInterval: =>
    @dmxOutputInterval = setInterval( =>
      @updateDmxOutputArray()
      @getArtnet().set 0, 1, @dmxOutoutArray
    , @env.clock.getDeltaMilliseconds())
