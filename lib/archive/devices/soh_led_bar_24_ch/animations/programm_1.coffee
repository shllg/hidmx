module.exports = class SimpleWaveAnimation extends require('./abstract')

  _currentAnimation: null

  initialize: (options = {}) =>
    super(options)

    # @_currentAnimation =

  getLength: =>
    # ????
    2 * Math.PI / @speed


  onTick: =>

  getCurrentAnimation: =>