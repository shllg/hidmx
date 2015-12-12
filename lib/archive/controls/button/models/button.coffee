module.exports = class ButtonModel extends require('../../abstract/models/model')

  defaults:
    value: 'off'

  toggle: (options = {}) =>
    if _.has options, 'on'
      @set 'value', if options.on == true then 'on' else 'false'
      return

    if @get('value') == 'on'
      @set 'value', 'off', options
    else
      @set 'value', 'on', options