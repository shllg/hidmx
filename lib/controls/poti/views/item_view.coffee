module.exports = class ControlsFaderView extends Marionette.ItemView

  template: tpl(__dirname, '../templates/item_view.jade')

  model: require('../models/poti')

  ui:
    poti:     '.controls-poti-unit'
    display:  '.controls-poti-display'

  modelEvents:
    'change:value': 'onModelChangeValue'

  onBeforeRender: =>

  onRender: =>
    @ui.display.text(@model.get('value'))

    @_range = 255

    # y = 0
    # @ui.valve[0].setAttribute('data-y', y)
    # @ui.valve[0].style.webkitTransform  = "translateY(#{y}px)"
    # @ui.valve[0].style.transform        = "translateY(#{y}px)"

    interact('.controls-poti-unit', {
      context: @.el
    }).draggable({
      inertia: true
      autoScroll: true
      axis: 'y'
      onmove: (event) =>
        dy = -1 * event.dy

        y = (parseFloat(@ui.poti[0].getAttribute('data-y')) || 0) + dy
        y = 0 if y < 0
        y = @_range if y > @_range

        @ui.poti[0].setAttribute('data-y', y)

        deg = parseInt(280 / @_range * y)
        val = parseInt(255 / @_range * y)

        @ui.poti[0].style.webkitTransform  = "rotateZ(#{deg}deg)"
        @ui.poti[0].style.transform        = "rotateZ(#{deg}deg)"

        @model.set 'value', val

    })

  onModelChangeValue: =>
    @ui.display.text(@model.get('value'))

