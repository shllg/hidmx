'use strict'

# deferred lib
global.Q = require '../node_modules/q'

# jquery + plugins
global.$ = require '../node_modules/jquery'
global.jquery = global.jQuery = global.$
require '../node_modules/jquery-serializejson'

# underscore
global._ = global.underscore = require '../node_modules/underscore'

# backbone & marionette
global.Backbone     = require '../node_modules/backbone'
global.backbone     = global.Backbone
global.Backbone.$   = $
global.Marionette   = require '../node_modules/backbone.marionette'
global.backbone.marionette = global.Marionette
global.backbone.radio = require '../node_modules/backbone.radio'

# other marionette plugins
require '../node_modules/backbone.babysitter'
require '../node_modules/backbone-relational'

# backbone radio shim
Marionette.Application.prototype._initChannel = ->
  @channelName  = _.result(@, 'channelName') || 'global'
  @channel      = _.result(@, 'channel') || backbone.radio.channel(@channelName)
