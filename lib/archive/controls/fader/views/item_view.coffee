module.exports = class ControlsFaderView extends require('../../abstract/views/item_view')

  template: tpl(__dirname, '../templates/item_view.jade')

  model: require('../models/fader')

  className: 'controls-fader'

  ui:
    slot:     '.controls-fader-slot'
    valve:    '.controls-fader-valve'
    display:  '.controls-fader-display'

  modelEvents:
    'change:value': 'onModelChangeValue'

  onRender: =>
    super()

  onAttach: =>
    @_height or= @ui.slot.outerHeight()
    @_update()

    interact('.controls-fader-valve', {
      context: @.el
    }).draggable({
      inertia: true
      autoScroll: true
      axis: 'y'
      restrict:
        restriction: 'parent'
      onmove: (event) =>
        delta = 255 / @_height * event.dy
        val   = parseInt(@model.get('value') - delta)
        val   = 0 if val < 0
        val   = 255 if val > 255

        @model.set('value', val)
    })

  _update: (value) =>
    @ui.display.text(@model.get('value'))

    height  = @_height * -1
    value   = parseInt(@model.get('value'))
    y       = parseInt(value / 255 * height)

    @ui.valve[0].style.webkitTransform  = "translateY(#{y}px)"
    @ui.valve[0].style.transform        = "translateY(#{y}px)"

  onModelChangeValue: =>
    @_update()



