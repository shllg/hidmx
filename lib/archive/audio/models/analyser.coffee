module.exports = class Analyser extends Backbone.Model

  _ready:           false
  _audioStream:     null
  _audioContext:    null
  _audioAnalyser:   null
  _audioSourceNode: null

  initialize: (options = {}) =>
    navigator.getUserMedia = @_resolveGetUserMediaFunction()
    return unless navigator.getUserMedia

    navigator.getUserMedia({ audio: true }, @_prepare, @_failure)

  destroy: =>
    return unless navigator.getUserMedia

    # todo

  isReady: =>
    @_ready == true

  getAudioStream: =>
    @_audioStream

  getAudioContext: =>
    @_audioContext or= new AudioContext()

  getAudioAnalyser: =>
    @_audioAnalyser

  getAudioSourceNode: =>
    @_audioSourceNode

  sync: => #disable

  # ---------------------------------------------
  # private methods

  # @nodoc
  _resolveGetUserMediaFunction: =>
    navigator.getUserMedia || navigator.webkitGetUserMedia ||
    navigator.mozGetUserMedia || navigator.msGetUserMedia

  # @nodoc
  _prepare: (stream) =>
    @_audioStream = stream

    @_audioAnalyser   = @getAudioContext().createAnalyser()
    @_audioSourceNode = @getAudioContext().createMediaStreamSource(@_audioStream)

    @_audioSourceNode.connect(@_audioAnalyser)

    array = new Uint8Array(@_audioAnalyser.frequencyBinCount)
    @_audioAnalyser.getByteFrequencyData(array)

    @_ready = true
    @trigger 'ready', @

  # @nodoc
  _failure: (error) =>
    console.error 'Failed to initialize audio stream from getUserMedia', error
