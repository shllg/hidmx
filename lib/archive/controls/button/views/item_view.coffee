module.exports = class ButtonView extends require('../../abstract/views/item_view')

  template: tpl(__dirname, '../templates/item_view.jade')

  model: require('../models/button')

  className: 'controls-button'

  events:
    'click':      'onClick'
    'mousedown':  'onMouseDown'
    'mouseup':    'onMouseUp'

  modelEvents:
    'change:value': 'onModelChangeValue'

  onClick: =>
    if @model.get('value') == 'on'
      @model.set('value', 'off')
    else
      @model.set('value', 'on')

  onModelChangeValue: =>
    if @model.get('value') == 'on'
      @.$el.addClass 'active'
    else
      @.$el.removeClass 'active'

  onMouseDown: (event) =>
    @.$el.addClass 'mousedown'

  onMouseUp: (event) =>
    @.$el.removeClass 'mousedown'
