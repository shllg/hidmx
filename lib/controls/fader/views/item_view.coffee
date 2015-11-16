module.exports = class ControlsFaderView extends Marionette.ItemView

  template: tpl(__dirname, '../templates/item_view.jade')

  model: require('../models/fader')

  ui:
    slot: '.controls-fader-slot'
    valve: '.controls-fader-valve'

  onBeforeRender: =>

  onRender: =>
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
        # y = y * -1

        @ui.valve[0].style.webkitTransform  = "translateY(#{y}px)"
        @ui.valve[0].style.transform        = "translateY(#{y}px)"

        @ui.valve[0].setAttribute('data-y', y)

      # onmove: (event) =>

      #   @_currentTop += event.dy
      #   @_currentTop = 0 if @_currentTop < 0
      #   @_currentTop =


      #   offset      =
      #   height      = @.$el.height()
      #   currentTop  = @ui.valve.position().top / height
      #   dragTop     = event.dy / height

      #   console.log @ui.valve.position().top
      #   console.log 'ONMOVE', currentTop, dragTop, currentTop + dragTop


    })

