midi = require 'midi'

module.exports = new (class NanoControlService extends Marionette.Object

  initialize: (options = {}) =>
    @_initInput()

    output = new midi.output()
    output.openPort(0)

    window.output = output
    # output.sendMessage([x,y,z])

    # _.times 255, (x) =>
    #   _.times 255, (y) =>
    #     _.times 255, (z) =>
    #       console.log [x, y, z]
    #       window.output.sendMessage([x, y, z])

  onMidiMessage: (deltaTime, message) =>
    @trigger 'message', message, deltaTime

  _initInput: =>
    @_input = new midi.input()
    @_input.on 'message', @onMidiMessage
    @_input.openPort(0)
    @_input.ignoreTypes(false, false, false)

)