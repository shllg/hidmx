MidiNanoControlService = require 'services/midi/nano_control_service'

ButtonControl     = require 'controls/button/models/button'
FaderControl      = require 'controls/fader/models/fader'
PotiControl       = require 'controls/poti/models/poti'
ButtonControlView = require 'controls/button/views/item_view'
FaderControlView  = require 'controls/fader/views/item_view'
PotiControlView   = require 'controls/poti/views/item_view'

module.exports = class ControlsLayoutView extends Marionette.LayoutView

  template: tpl(__dirname, '../../templates/controls/layout.jade')

  className: 'device-controls soh_led_bar_24_ch'

  ui:
    insideContainer: '.soh_led_bar_24_ch-inside'

  views: null

  initialize: (options = {}) =>
    @views = []

  onBeforeRender: =>
    _.each @views, (view) => view.destroy()
    @views = []

  onRender: =>
    @.$el.attr('id', "controls-#{@model.get('id')}")

  onAttach: =>
    @_initViews()

  # ---------------------------------------------
  # private methods

  # @nodoc
  _initViews: =>

    # ////////////////////////////////////////////////////////////////////////////////
    model = new FaderControl()
    view  = new FaderControlView({ model: model, additionalClasses: 'fader-1' })
    view.render()
    @ui.insideContainer.append(view.$el)
    @views.push view

    fader1 = model
    @listenTo MidiNanoControlService, 'message', (message, deltaTime) =>
      return unless message[0] == 176
      return unless message[1] == 0
      fader1.set 'value', (2 * message[2])

    # ////////////////////////////////////////////////////////////////////////////////
    model = new FaderControl()
    view  = new FaderControlView({ model: model, additionalClasses: 'fader-2' })
    view.render()
    @ui.insideContainer.append(view.$el)
    @views.push view

    fader2 = model
    @listenTo MidiNanoControlService, 'message', (message, deltaTime) =>
      return unless message[0] == 176
      return unless message[1] == 1
      fader2.set 'value', (2 * message[2])

    # ////////////////////////////////////////////////////////////////////////////////
    model = new FaderControl()
    view  = new FaderControlView({ model: model, additionalClasses: 'fader-3' })
    view.render()
    @ui.insideContainer.append(view.$el)
    @views.push view

    fader3 = model
    @listenTo MidiNanoControlService, 'message', (message, deltaTime) =>
      return unless message[0] == 176
      return unless message[1] == 2
      fader3.set 'value', (2 * message[2])

    # ////////////////////////////////////////////////////////////////////////////////
    model = new PotiControl()
    view = new PotiControlView({ model: model, additionalClasses: 'poti-1' })
    view.render()
    @ui.insideContainer.append(view.$el)
    @views.push view

    # ////////////////////////////////////////////////////////////////////////////////
    model = new PotiControl()
    view = new PotiControlView({ model: model, additionalClasses: 'poti-2' })
    view.render()
    @ui.insideContainer.append(view.$el)
    @views.push view

    # ////////////////////////////////////////////////////////////////////////////////
    model = new PotiControl()
    view = new PotiControlView({ model: model, additionalClasses: 'poti-3' })
    view.render()
    @ui.insideContainer.append(view.$el)
    @views.push view

    # ////////////////////////////////////////////////////////////////////////////////
    model = new ButtonControl()
    view  = new ButtonControlView({ model: model, additionalClasses: 'button-1' })
    view.render()
    @ui.insideContainer.append(view.$el)
    @views.push view

    button1 = model
    @listenTo MidiNanoControlService, 'message', (message, deltaTime) =>
      return unless message[0] == 176
      return unless message[1] == 32
      button1.toggle({ on: message[2] == 127 })

    # ////////////////////////////////////////////////////////////////////////////////
    model = new ButtonControl()
    view  = new ButtonControlView({ model: model, additionalClasses: 'button-2' })
    view.render()
    @ui.insideContainer.append(view.$el)
    @views.push view

    button2 = model
    @listenTo MidiNanoControlService, 'message', (message, deltaTime) =>
      return unless message[0] == 176
      return unless message[1] == 48
      button2.toggle({ on: message[2] == 127 })

    # ////////////////////////////////////////////////////////////////////////////////
    model = new ButtonControl()
    view  = new ButtonControlView({ model: model, additionalClasses: 'button-3' })
    view.render()
    @ui.insideContainer.append(view.$el)
    @views.push view

    button3 = model
    @listenTo MidiNanoControlService, 'message', (message, deltaTime) =>
      return unless message[0] == 176
      return unless message[1] == 64
      button3.toggle({ on: message[2] == 127 })

    # ////////////////////////////////////////////////////////////////////////////////
    model = new ButtonControl()
    view  = new ButtonControlView({ model: model, additionalClasses: 'button-4' })
    view.render()
    @ui.insideContainer.append(view.$el)
    @views.push view

    # ////////////////////////////////////////////////////////////////////////////////
    model = new ButtonControl()
    view  = new ButtonControlView({ model: model, additionalClasses: 'button-5' })
    view.render()
    @ui.insideContainer.append(view.$el)
    @views.push view

    # ////////////////////////////////////////////////////////////////////////////////
    model = new ButtonControl()
    view  = new ButtonControlView({ model: model, additionalClasses: 'button-6' })
    view.render()
    @ui.insideContainer.append(view.$el)
    @views.push view

    # ////////////////////////////////////////////////////////////////////////////////
    model = new ButtonControl()
    view  = new ButtonControlView({ model: model, additionalClasses: 'button-7' })
    view.render()
    @ui.insideContainer.append(view.$el)
    @views.push view

    # ////////////////////////////////////////////////////////////////////////////////
    model = new ButtonControl()
    view  = new ButtonControlView({ model: model, additionalClasses: 'button-8' })
    view.render()
    @ui.insideContainer.append(view.$el)
    @views.push view

    # ////////////////////////////////////////////////////////////////////////////////
    model = new ButtonControl()
    view  = new ButtonControlView({ model: model, additionalClasses: 'button-9' })
    view.render()
    @ui.insideContainer.append(view.$el)
    @views.push view

    # ////////////////////////////////////////////////////////////////////////////////
    window.requestAnimationFrame =>
      _.each @views, (view) =>
        view.triggerMethod 'attach'




