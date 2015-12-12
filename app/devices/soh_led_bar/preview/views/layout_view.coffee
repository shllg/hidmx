module.exports = class LayoutView extends Marionette.LayoutView

  template: tpl(__dirname, '../templates/layout_view.jade')

  className: 'device-preview'

  initialize: (options = {}) =>
    @env    = options.env
    @device = options.device

  onRender: =>
    @.$el.attr 'id', "device-preview-#{@device.id}"