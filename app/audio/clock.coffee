module.exports = class Clock extends Backbone.Model

  defaults:

    # 1/0.05s == 20Hz ~ 20 ticks per second
    clockFrequency: 20

  initialize: (attrs, options) =>
    @env = options.env

    @_startClock()

  destroy: =>
    @_stopClock()

  sync: => #disable

  getDeltaMilliseconds: =>
    1 / @get('clockFrequency') * 1000

  # ---------------------------------------------
  # private methods

  # @nodoc
  _startClock: =>
    @_clock = setInterval(=>
      @trigger 'clock:tick', @
    , (1 / @get('clockFrequency')) * 1000)

  _stopClock: =>
    clearInterval(@_clock) if @_clock
    @_clock = null
