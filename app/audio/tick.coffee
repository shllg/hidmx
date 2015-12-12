module.exports = class Tick extends Backbone.Model

  defaults:

    # low frequency config
    lowFreqStart: 0
    lowFreqEnd: 7350
    lowFreqThreshold: 0
    lowFreqCurrentValue: 0

    # mid frequency config
    midFreqStart: 7351
    midFreqEnd: 14701
    midFreqThreshold: 0
    midFreqCurrentValue: 0

    # hi frequency config
    hiFreqStart: 14701
    hiFreqEnd: 22050
    hiFreqThreshold: 0
    hiFreqCurrentValue: 0

    # Sets the sensitivity of the algorithm. After a beat has been detected, the
    # algorithm will wait for <code>millis</code> milliseconds before allowing
    # another beat to be reported. You can use this to dampen the algorithm if
    # it is giving too many false-positives. The default value is 10, which is
    # essentially no damping. If you try to set the sensitivity to a negative
    # value, an error will be reported and it will be set to 10 instead.
    beatdetectSensitivity: 300

  initialize: (attrs, options) =>
    @env = options.env

    BpmDetect = require('./bpm_detect')
    @_bpmDetectKick = new BpmDetect({ env: @env })

    @listenTo @env.clock, 'clock:tick', @onClockTick

    @listenTo @env.analyser, 'ready', =>
      @beatdetect = new FFT.BeatDetect(@env.analyser.getAudioAnalyser().frequencyBinCount, @_sampleRate())
      @beatdetect.setSensitivity(@get('beatdetectSensitivity'))


  onClockTick: =>
    array = @getFrequencyByteData()
    return unless array? && _.any(array)
    return unless @beatdetect?

    floats = new Float32Array(@env.analyser.getAudioAnalyser().frequencyBinCount)
    @env.analyser.getAudioAnalyser().getFloatTimeDomainData(floats)

    @beatdetect.detect(floats);

    # console.log("isKick()") if @beatdetect.isKick()
    # console.log("isSnare()") if @beatdetect.isSnare()

    if @beatdetect.isKick()
      @_bpmDetectKick.tap()
      # console.log @_bpmDetectKick.simpleBeats, @_bpmDetectKick.simpleTime, @_bpmDetectKick.simplePosition, @_bpmDetectKick.simplePosition, @_bpmDetectKick.simpleTempo, @_bpmDetectKick.simplePeriod, @_bpmDetectKick.advancedPeriod, @_bpmDetectKick.advancedOffset, @_bpmDetectKick.advancedCorrelation, @_bpmDetectKick.advancedTempo, @_bpmDetectKick.simpleLastDev, @_bpmDetectKick.advancedStdDev, @_bpmDetectKick.advancedLastDev
      # console.log @_bpmDetectKick.simpleTempo, @_bpmDetectKick.advancedTempo



  getTickData: =>
    @_calculate()

    {
      low:  @get('lowFreqCurrentValue'),
      mid:  @get('midFreqCurrentValue'),
      high: @get('hiFreqCurrentValue'),
    }

  getFrequencyByteData: =>
    @env.analyser.getFrequencyByteData()

  _calculate: =>
    @set 'lowFreqCurrentValue', @_calculateForFrequencyBand(@get('lowFreqStart'), @get('lowFreqEnd'))
    @set 'midFreqCurrentValue', @_calculateForFrequencyBand(@get('midFreqStart'), @get('midFreqEnd'))
    @set 'hiFreqCurrentValue',  @_calculateForFrequencyBand(@get('hiFreqStart'), @get('hiFreqEnd'))

  _calculateForFrequencyBand: (startFreq, stopFreq) =>
    array       = @env.analyser.getFrequencyByteData()
    startIndex  = @_frequencyToArrayIndex(startFreq) || 0
    stopIndex   = @_frequencyToArrayIndex(stopFreq) || 0
    steps       = (stopIndex - startIndex)
    power       = 0

    _.times steps, (i) =>
      power += array[startIndex + i]

    # console.log startIndex, stopIndex, parseInt(power / steps)
    parseInt(power / steps)


  _sampleRate: =>
    @env.analyser.getAudioContext().sampleRate

  _fftSize: =>
    @env.analyser.getAudioAnalyser().fftSize

  _arraySize: =>
    @env.analyser.getFrequencyByteData().length

  _frequencyToArrayIndex: (freq) =>
    # 0Hz to 22050Hz
    # frequency steps: (= samplerate / fftSize)
    maxFreq = @_arraySize() * @_sampleRate() / @_fftSize()
    # console.log freq, @_sampleRate(), @_fftSize()
    parseInt(freq / (@_sampleRate() / @_fftSize()))
