ControlConfig = require './models/control_config'
SimulatorView = require './views/simulator/simulator_view'
ControlView   = require './views/controls/layout_view'

module.exports = class Device extends require('../abstract/device')

  id: null

  tmpClock: =>
    @getSimulatorView().render()

  initialize: (options = {}) =>
    @id = options.id

  getSimulatorView: =>
    @_simulatorView or= new SimulatorView({ model: @getControlConfig() })

  getControlView: =>
    @_controlView or= new ControlView({ model: @getControlConfig() })

  getControlConfig: =>
    @_controlConfig or= new ControlConfig({ id: @id })