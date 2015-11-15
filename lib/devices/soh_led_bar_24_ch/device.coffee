ControlConfig = require './models/control_config'
SimulatorView = require './views/simulator/layout_view'

module.exports = class Device extends require('../abstract/device')

  getSimulatorView: =>
    @_simulatorView or= new SimulatorView()