module.exports = class AbstractAnimation extends Marionette.Object

  _tickCount: 0

  clock:  null
  data:   null

  durationCounter: 0.0

  initialize: (options = {}) =>
    @clock = options.clock
    @data = [
      0, 0, 0,
      0, 0, 0,
      0, 0, 0,
      0, 0, 0,
      0, 0, 0,
      0, 0, 0,
      0, 0, 0,
      0, 0, 0,
    ]

  start: =>
    @triggerMethod 'on:before:start'
    @listenTo @clock, 'clock:tick', @tick
    @triggerMethod 'on:start'

  stop: =>
    @triggerMethod 'on:before:stop'
    @stopListening @clock
    @triggerMethod 'on:stop'

  restart: =>
    @stop()
    @start()

  getData: =>
    @data

  tick: =>
    @onTick()
    @_tickCount += 1

    if @durationCounter >= @getLength()
      @triggerMethod 'loop:finish'
      @trigger 'loop:finish'
      @durationCounter -= @getLength()
    @durationCounter += 1.0

  onTick: =>

  getTickCount: =>
    @_tickCount

  getLength: =>
    1