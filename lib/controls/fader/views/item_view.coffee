module.exports = class ControlsFaderView extends Marionette.ItemView

  template: tpl(__dirname, '../templates/item_view.jade')

  model: require('../models/fader')

  ui:
    slot:     '.controls-fader-slot'
    valve:    '.controls-fader-valve'
    display:  '.controls-fader-display'

  modelEvents:
    'change:value': 'onModelChangeValue'

  onBeforeRender: =>

  onRender: =>
    @ui.display.text(@model.get('value'))

    y = 0
    @ui.valve[0].setAttribute('data-y', y)
    @ui.valve[0].style.webkitTransform  = "translateY(#{y}px)"
    @ui.valve[0].style.transform        = "translateY(#{y}px)"

    interact('.controls-fader-valve', {
      context: @.el
    }).draggable({
      inertia: true
      autoScroll: true
      axis: 'y'
      restrict:
        restriction: 'parent'
      onmove: (event) =>
        height = @ui.slot.height() * -1
        y = (parseFloat(@ui.valve[0].getAttribute('data-y')) || 0) + event.dy
        y = 0 if y > 0
        y = height if y < height

        @ui.valve[0].style.webkitTransform  = "translateY(#{y}px)"
        @ui.valve[0].style.transform        = "translateY(#{y}px)"

        @ui.valve[0].setAttribute('data-y', y)

        @model.set 'value', parseInt(255 * y / height)

    })

  onModelChangeValue: =>
    @ui.display.text(@model.get('value'))

