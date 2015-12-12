module.exports = class App extends Marionette.Application

  onStart: =>
    # init env
    @getEnv()

    # devices
    @registerDevice 'ledBar001',       './devices/soh_led_bar/device'
    @registerDevice 'adjRevo001',      './devices/adj_revo_4/device'
    @registerDevice 'adjQuadPhase001', './devices/adj_quad_phase/device'

    # layout view
    layoutView = new (require('./views/layout_view'))({ env: @getEnv() })
    $('body').append(layoutView.$el)
    layoutView.render()

    # dmx manager
    @getDmxManager()

    # midi manager
    @getMidiManager()

  getEnv: =>
    @_env or= new (require('./helpers/env'))()

  getDmxManager: =>
    @_dmxManager or= new (require('./dmx_manager/manager'))({ env: @getEnv() })

  getMidiManager: =>
    @_midiManager or= new (require('./midi_manager/manager'))({ env: @getEnv() })

  registerDevice: (id, deviceModulePath) =>
    @getEnv().registerDevice(
      id,
      new (require(deviceModulePath))({ id: id, env: @getEnv() })
    )