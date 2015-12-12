module.exports = class AbstractItemView extends Marionette.ItemView

  initialize: (options = {}) =>
    @_additionalClasses = options.additionalClasses || ''

  onRender: =>
    @.$el.addClass @_additionalClasses
