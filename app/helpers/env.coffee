module.exports = class Env extends Marionette.Object

  config:   null

  analyser: null
  clock:    null
  tick:     null
  force:    null

  devices:  null

  initialize: =>
    @config     = new (require('../models/config'))({}, { env: @ })
    @analyser   = new (require('../audio/analyser'))({}, { env: @ })
    @clock      = new (require('../audio/clock'))({}, { env: @ })
    @tick       = new (require('../audio/tick'))({}, { env: @ })
    @force      = new (require('../audio/force'))({}, { env: @ })

    @devices  = {}

  registerDevice: (name, deviceModule) =>
    @devices[name] = deviceModule

  getDevice: (name) =>
    @devices[name]