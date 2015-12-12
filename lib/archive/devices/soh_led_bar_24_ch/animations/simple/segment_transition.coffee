###

* linearTween
* easeInQuad
* easeOutQuad
* easeInOutQuad
* easeInCubic
* easeOutCubic
* easeInOutCubic
* easeInQuart
* easeOutQuart
* easeInOutQuart
* easeInQuint
* easeOutQuint
* easeInOutQuint
* easeInSine
* easeOutSine
* easeInOutSine
* easeInExpo
* easeOutExpo
* easeInOutExpo
* easeInCirc
* easeOutCirc
* easeInOutCirc

###
module.exports = class SegmentTransitionAnimation extends require('./abstract')

  speed: 1
  clockFrequency: 20
  offsets: null
  functionName: 'linearTween'

  _subTickCount: 0

  initialize: (options = {}) =>
    super(options)

    @offsets = [0, 0, 0, 0, 0, 0, 0, 0]

    # @functionName = 'easeInOutQuad'
    # @offsets = [0, 0.5, 0, 0.5, 0, 0.5, 0, 0.5]
    # @offsets = [1/8, 2/8, 3/8, 4/8, 5/8, 6/8, 7/8, 8/8]
    # @offsets = [1/8, 1/8, 2/8, 2/8, 3/8, 3/8, 4/8, 4/8]
    # @offsets = [0, 0.25, 0.5, 0, 0.25, 0.5, 0, 0.25]

  getLength: =>
    2 * @clockFrequency / @speed

  onTick: =>
    _.times 8, (i) =>
      offset = @offsets[i] * @getLength() / 2
      value = parseInt(@_valueFunction(@_subTickCount + offset))
      @data[i * 3 + 0] = value
      @data[i * 3 + 1] = value
      @data[i * 3 + 2] = value

    @_subTickCount += 1
    @_subTickCount = 0 if @_subTickCount >= @getLength()

  _valueFunction: (count) =>
    count = count - @getLength() if count >= @getLength()
    hl    = @getLength() / 2

    if count < hl
      Math.functions[@functionName].call(Math.functions, count, 0, 255, hl)
    else
      255 - Math.functions[@functionName].call(Math.functions, count - hl, 0, 255, hl)




