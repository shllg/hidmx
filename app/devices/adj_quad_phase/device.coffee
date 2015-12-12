module.exports = class AdjQuadPhaseDevice extends Marionette.Object

  id:   null
  env:  null

  initialize: (options = {}) =>
    @id   = if options.id? then options.id else _.uniqueId('device-')
    @env  = options.env

  getChannelsCount: =>
    4

  getData: =>
    [ 0, 0, 0, 0 ]

  getPreviewView: =>
    @_previewView or= new (require('./preview/views/layout_view'))({ device: @, env: @env })

  getControlsView: =>
    @_controlsView or= new (require('./controls/views/layout_view'))({ device: @, env: @env })

