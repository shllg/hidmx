module.exports = class AbstractDevice extends Marionette.Object

  getSimulatorView: =>
    throw 'Implement function'

  getControlView: =>
    throw 'Implement function'