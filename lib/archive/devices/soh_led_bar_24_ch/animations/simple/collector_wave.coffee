module.exports = class CollectorWaveAnimation extends require('./abstract')

  backwards:  false
  speed:      0.5
  phase:      1
  delta:      2
  return:     false

  memoryData:           null
  currentAnimationData: null
  currentUnfilledState: 7

  subDurationCounter: 0

  initialize: (options = {}) =>
    super(options)

    @memoryData           = [].concat(@getData())
    @currentAnimationData = [].concat(@getData())

  getLength: =>
    8 * 2 * @getSubLength()

  getSubLength: =>
    2 * Math.PI / @speed

  onSubLoopFinish: =>
    @return = true if @currentUnfilledState == 0

    if @return == false
      value       = 255
      increment   = -1
    else
      value       = 0
      increment   = 1

    @memoryData[@currentUnfilledState * 3 + 0] = value
    @memoryData[@currentUnfilledState * 3 + 1] = value
    @memoryData[@currentUnfilledState * 3 + 2] = value

    @currentUnfilledState += increment

    if @return == false
      @currentUnfilledState = 0 if @currentUnfilledState < 0
    else
      @currentUnfilledState = 7 if @currentUnfilledState >= 7

  onLoopFinish: =>
    @return                 = false
    @subDurationCounter     = 0
    @data                   = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    @memoryData             = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    @currentAnimationData   = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    @currentUnfilledState   = 7

  onTick: =>
    _.times 8, (i) =>
      modifier  = -1
      modifier  = modifier * -1 if @return == true
      val       = @_sinValue(modifier * @getTickCount() + i, @speed, @phase, @delta)
      @currentAnimationData[i * 3 + 0] = val
      @currentAnimationData[i * 3 + 1] = val
      @currentAnimationData[i * 3 + 2] = val

    @_writeToData()

    if @subDurationCounter >= @getSubLength()
      @triggerMethod 'sub:loop:finish'
      @subDurationCounter -= @getSubLength()
    @subDurationCounter += 1.0

  _sinValue: (x, speed, phase, delta) =>
    val = (Math.sin(x * speed + phase - (Math.PI / 2)) + 1) * 0.5
    val = Math.pow(val, delta) * 255
    val = parseInt(val)

    if val < 0 then 0 else val

  _writeToData: =>
    _.times 3 * 8, (i) =>
      @data[i] = @memoryData[i] + @currentAnimationData[i]
      @data[i] = 255 if @data[i] > 255
