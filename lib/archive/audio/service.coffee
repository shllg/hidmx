###

Facts:

  * samplerate: getAnalyser().getAudioContext().sampleRate      - e.g. 44100
  * fftSize:    getAnalyser().getAudioAnalyser().fftSize        - e.g. 2048
  * arraySize:  getFrequencyByteData().length                   - e.g. 1024
  * Frequency tracking will got from 0Hz to 22050Hz (= arraySize * samplerate / fftSize)
  * Frequency steps will be ~21.533203125Hz (= samplerate / fftSize)

Methods:

  * getClock              - clock instance
  * getAnalyser           - analyser instance
  * getFrequencyByteData  - array of frequency steps with power for each - see for reference:
                            https://developer.mozilla.org/en-US/docs/Web/API/AnalyserNode/getByteFrequencyData

###
module.exports = new (class AudioService extends Marionette.Object

  getClock: =>
    @_clock or= new (require('./models/clock'))()

  getTick: =>
    @_tick or= new (require('./models/wave_tick'))()

  getAnalyser: =>
    @_analyser or= new (require('./models/analyser'))()

  getFrequencyByteData: =>
    array = new Uint8Array(@getAnalyser().getAudioAnalyser().frequencyBinCount)

    @getAnalyser().getAudioAnalyser().getByteFrequencyData(array)

    array

)