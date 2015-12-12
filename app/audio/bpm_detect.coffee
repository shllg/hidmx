module.exports = class BpmDetect extends Marionette.Object

  env: null

  startTime:  null
  beatTimes:  null
  xsum:       null
  xxsum:      null
  ysum:       null
  yysum:      null
  xysum:      null
  periodprev: null
  aprev:      null
  bprev:      null
  isDone:     null

  simpleBeats:          null  # Beats (counts)
  simpleTime:           null  #
  simplePosition:       null  # Position (bar : beat)
  simpleTempo:          null  # Tempo (BPM)
  simplePeriod:         null  #
  advancedPeriod:       null  #
  advancedOffset:       null  #
  advancedCorrelation:  null  #
  advancedTempo:        null  # Tempo (BPM)
  simpleLastDev:        null  #
  advancedStdDev:       null  #
  advancedLastDev:      null  #


  initialize: (options) =>
    @env = options.env

    @startTime  = null
    @beatTimes  = []
    @xsum       = 0;
    @xxsum      = 0;
    @ysum       = 0;
    @yysum      = 0;
    @xysum      = 0;
    @isDone     = false

  tap: =>
    @countBeat(Date.now()) if !@isDone
    return true

  countBeat: (currTime) =>
    # Coordinates for linear regression
    startTime = currTime if @startTime == null
    x         = @beatTimes.length
    y         = currTime - @startTime

    # Add beat
    @beatTimes.push(y)
    beatCount     = @beatTimes.length
    @simpleBeats  = beatCount
    @simpleTime   = (y / 1000).toFixed(3)

    # Regression cumulative variables
    @xsum  += x
    @xxsum += x * x
    @ysum  += y
    @yysum += y * y
    @xysum += x * y

    tempo = 60000 * x / y
    if (beatCount < 8 || tempo < 190)
      @simplePosition = Math.floor(x / 4) + " : " + x % 4
    else  # Two taps per beat
      @simplePosition = Math.floor(x / 8) + " : " + Math.floor(x / 2) % 4 + "." + x % 2 * 5

    if beatCount >= 2
      # Period and tempo, simple
      period        = y / x
      @simpleTempo  = tempo.toFixed(2)
      @simplePeriod = period.toFixed(2)

      # Advanced
      xx = beatCount * @xxsum - @xsum * @xsum
      yy = beatCount * @yysum - @ysum * @ysum
      xy = beatCount * @xysum - @xsum * @ysum
      a = (beatCount * @xysum - @xsum * @ysum) / xx  # Slope
      b = (@ysum * @xxsum - @xsum * @xysum) / xx  # Intercept
      console.log 'tempo', 60000 * x / y, 60000 / a, x, y, a
      @advancedPeriod       = a.toFixed(3)
      @advancedOffset       = b.toFixed(3)
      @advancedCorrelation  = (xy * xy / (xx * yy)).toFixed(9)
      @advancedTempo        = (60000 / a).toFixed(3)

      # Deviations from prediction
      if beatCount >= 3
        @simpleLastDev    = (@periodprev * x - y).toFixed(1)
        @advancedStdDev   = (Math.sqrt(((yy - xy * xy / xx) / beatCount) / (beatCount - 2))).toFixed(3)
        @advancedLastDev  = (@aprev * x + @bprev - y).toFixed(1)

      @periodprev = period
      @aprev      = a
      @bprev      = b

  done: =>
    @isDone = true
    @simplePosition   = ''
    @simpleLastDev    = ''
    @advancedLastDev  = ''

