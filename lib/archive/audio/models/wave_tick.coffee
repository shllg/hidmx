AudioService = require '../service'

module.exports = class WaveTick extends Backbone.Model

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

  getTickData: =>
    @_calculate()

    {
      low:  @get('lowFreqCurrentValue'),
      mid:  @get('midFreqCurrentValue'),
      high: @get('hiFreqCurrentValue'),
    }

  getFrequencyByteData: =>
    AudioService.getFrequencyByteData()

  _calculate: =>
    @set 'lowFreqCurrentValue', @_calculateForFrequencyBand(@get('lowFreqStart'), @get('lowFreqEnd'))
    @set 'midFreqCurrentValue', @_calculateForFrequencyBand(@get('midFreqStart'), @get('midFreqEnd'))
    @set 'hiFreqCurrentValue',  @_calculateForFrequencyBand(@get('hiFreqStart'), @get('hiFreqEnd'))

  _calculateForFrequencyBand: (startFreq, stopFreq) =>
    array       = AudioService.getFrequencyByteData()
    startIndex  = @_frequencyToArrayIndex(startFreq) || 0
    stopIndex   = @_frequencyToArrayIndex(stopFreq) || 0
    steps       = (stopIndex - startIndex)
    power       = 0

    _.times steps, (i) =>
      power += array[startIndex + i]

    # console.log startIndex, stopIndex, parseInt(power / steps)
    parseInt(power / steps)


  _sampleRate: =>
    AudioService.getAnalyser().getAudioContext().sampleRate

  _fftSize: =>
    AudioService.getAnalyser().getAudioAnalyser().fftSize

  _arraySize: =>
    AudioService.getFrequencyByteData().length

  _frequencyToArrayIndex: (freq) =>
    # 0Hz to 22050Hz
    # frequency steps: (= samplerate / fftSize)
    maxFreq = @_arraySize() * @_sampleRate() / @_fftSize()
    # console.log freq, @_sampleRate(), @_fftSize()
    parseInt(freq / (@_sampleRate() / @_fftSize()))
