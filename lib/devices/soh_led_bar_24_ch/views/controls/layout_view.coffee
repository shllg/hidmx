module.exports = class ControlsLayoutView extends Marionette.LayoutView

  template: tpl(__dirname, '../../templates/controls/layout.jade')

  serializeData: =>
    name: 'TEST'