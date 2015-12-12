#
# 1. "midi" node package
#
# CC=/usr/bin/cc CXX=/usr/bin/c++ npm install midi --save
#

#
# 2. "soundflower" to channel audio into input
#
# https://github.com/RogueAmoeba/Soundflower-Original
# https://www.youtube.com/watch?v=kyS7UG3wmb0&feature=youtu.be
# https://github.com/mattingalls/Soundflower/releases
#
#



require('app-module-path').addPath(__dirname);

sass = require('node-sass')


jade = require('jade')
path = require('path')
fs = require('fs')
global.tpl = (dirname, relPath) ->
  jadeContent = fs.readFileSync(path.join(dirname, relPath), { encoding: 'utf8' })
  fn = jade.compile(jadeContent)
  _.template(fn())

require './libs'

_.templateSettings = {
  interpolate: /\{\{=(.+?)\}\}/g,
  evaluate: /\{\{(.+?)\}\}/g,
}


sass = require('node-sass')
style = sass.render({
  file: path.join(__dirname, '../stylesheets/main.sass')
  includePaths: [
    'bower_components/bourbon/app/assets/stylesheets'
  ]
}, (err, result) =>
  jQuery('head').append("<style media='all' rel='stylesheet'>#{result.css.toString()}</style>")
)



require('./dmx_runner_xmas')






# SohLedBar24ChDevice = require('./devices/soh_led_bar_24_ch/device')

# led = new SohLedBar24ChDevice()

# ledSimulatorView = led.getSimulatorView()
# ledSimulatorView.render()

# ledControlView = led.getControlView()
# ledControlView.render()

# $('body').append(ledSimulatorView.$el)
# $('body').append(ledControlView.$el)


# FaderControl      = require('./controls/fader/models/fader')
# FaderControlView  = require('./controls/fader/views/item_view')
# model = new FaderControl()
# view = new FaderControlView({ model: model })
# view.render()
# $('body').append(view.$el)

# PotiControl      = require('./controls/poti/models/poti')
# PotiControlView  = require('./controls/poti/views/item_view')
# model = new PotiControl()
# view = new PotiControlView({ model: model })
# view.render()
# $('body').append(view.$el)



# 60fps = 17 ms
# 10fps = 100 ms

# setInterval =>
#   ledSimulatorView.render()
# , 100





# if (navigator.getUserMedia) {
#     navigator.getUserMedia({audio: true}, function(stream) {
#         aCtx = new AudioContext();
#         analyser = aCtx.createAnalyser();
#         microphone = aCtx.createMediaStreamSource(stream);
#         microphone.connect(analyser);
#         analyser.connect(aCtx.destination);
#     }, function (){console.warn("Error getting audio stream from getUserMedia")});
# };


# AudioContext = AudioContext
# navigator.getUserMedia = ( navigator.getUserMedia    || navigator.webkitGetUserMedia || navigator.mozGetUserMedia ||navigator.msGetUserMedia)

# AudioService = require './audio/service'
# AudioService.getAnalyser()

# c = null
# context = null
# canvasContext = null
# canvasDrawContext = null
# rafID = null

# initBinCanvas = =>
#   # add new canvas
#   $("body").append('<h1>Frequenzanalyse</h1><h2>FFT:Ausgabe der Amplitude der jeweiligen Bins (Frequenzbereiche) in Hz</h2><canvas id="freq" width="'+(window.innerWidth - 50)+'" height="325" style="background:black;"></canvas><br>')
#   $("body").append('<canvas id="draw" width="'+(window.innerWidth - 50)+'" height="325" style="background:black;"></canvas><br>')

#   # get context from canvas for drawing
#   c = document.getElementById("freq")
#   canvasContext = c.getContext("2d")

#   # get context from canvas for drawing
#   c = document.getElementById("draw")
#   canvasDrawContext = c.getContext("2d")

#   # create gradient for the bins
#   gradient = canvasContext.createLinearGradient(0,0,0,300)
#   gradient.addColorStop(1,'#000000') # black
#   gradient.addColorStop(0.75,'#ff0000') # red
#   gradient.addColorStop(0.25,'#ffff00') # yellow
#   gradient.addColorStop(0,'#ffffff') # white

#   # set new gradient as fill style
#   canvasContext.fillStyle = gradient

# drawBars = (array) =>
#   # just show bins with a value over the treshold
#   threshold = 0
#   #  clear the current state
#   canvasContext.clearRect(0, 20, c.width, c.height)
#   # the max count of bins for the visualization
#   maxBinCount = array.length
#   # space between bins
#   space = 15

#   # go over each bin
#   _.times maxBinCount, (i) =>
#     value = array[i]

#     if value >= threshold
#       # draw bin
#       canvasContext.fillRect(5 + i * space, c.height - value, 5 , c.height)

#       # draw every second bin area in hertz
#       if i % 2 == 0
#         canvasContext.font = '12px sans-serif'
#         canvasContext.textBaseline = 'bottom'
#         canvasContext.fillText(Math.floor(AudioService.getAnalyser().getAudioContext().sampleRate / AudioService.getAnalyser().getAudioAnalyser().fftSize * i), i * space + 5, 20)

# drawSpectrogram = (array) =>
#   canvas = document.getElementById("draw")
#   # max count is the height of the canvas
#   max = if array.length > canvas.height then canvas.height else array.length
#   # move the current pixel one step left
#   imageData = canvasDrawContext.getImageData(0,0,canvas.width,canvas.height)
#   canvasDrawContext.putImageData(imageData,-1,0)
#   # iterate over the elements from the array
#   _.times max, (i) =>
#     # draw each pixel with the specific color
#     value = array[i]
#     # calc the color of the point
#     canvasDrawContext.fillStyle = getColor(value)
#     # draw the line at the right side of the canvas
#     canvasDrawContext.fillRect(canvas.width - 1, canvas.height - i, 1, 1)

# getColor = (v) =>
#   maxVolume = 255
#   # get percentage of the max volume
#   p = v / maxVolume
#   np = null

#   if p < 0.05
#     np = [0,0,0] # black
#   else if p < 0.25    # p is between 0.05 and 0.25
#     np = [parseInt(255 * (1-p)),0,0] # between black and red
#   else if p < 0.75    # p is between 0.25 and 0.75
#     np = [255,parseInt(255 * (1-p)),0]     # between red and yellow
#   else                # p is between 0.75 and 1
#     np = [255,255,parseInt(255 * (1-p))] # between yellow and white

#   return 'rgb('+ (np[0]+","+np[1]+","+np[2]) + ")"

# updateVisualization = =>
#   array = AudioService.getFrequencyByteData()

#   # console.log array
#   drawBars(array)
#   # console.log array.length
#   drawSpectrogram(array)
#   rafID = window.requestAnimationFrame(updateVisualization)

# analyserReadyFunction = ->
#   initBinCanvas()

#   #
#   # N * samplerate/fftSize
#   # ==
#   # array.length * AudioService.getAnalyser().getAudioContext().sampleRate / AudioService.getAnalyser().getAudioAnalyser().fftSize
#   #
#   array = AudioService.getFrequencyByteData()
#   console.log array
#   val1 = AudioService.getAnalyser().getAudioContext().sampleRate / AudioService.getAnalyser().getAudioAnalyser().fftSize
#   val2 = array.length * val1
#   console.log 'N: ', array.length, ', samplerate: ', AudioService.getAnalyser().getAudioContext().sampleRate, ', fftSize: ', AudioService.getAnalyser().getAudioAnalyser().fftSize
#   console.log "Overall range: 0Hz - #{val2}Hz", "Step size: #{val1}Hz"
#   #
#   #
#   #

#   rafID = window.requestAnimationFrame(updateVisualization)


# if AudioService.getAnalyser().isReady()
#   analyserReadyFunction()
# else
#   AudioService.getAnalyser().on 'ready', analyserReadyFunction









# --------------------------------------------------------------------------------
# START tick
# --------------------------------------------------------------------------------

# c = null
# context = null
# canvasContext = null
# canvasDrawContext = null
# rafID = null

# initTickCanvas = ->
#   # add new canvas
#   $("body").append('<canvas id="tick" width="350" height="325" style="background:black;"></canvas><br>')

#   # get context from canvas for drawing
#   c = document.getElementById("tick")
#   canvasContext = c.getContext("2d")

#   # create gradient for the bins
#   gradient = canvasContext.createLinearGradient(0,0,0,300)
#   gradient.addColorStop(1,'#000000') # black
#   gradient.addColorStop(0.75,'#ff0000') # red
#   gradient.addColorStop(0.25,'#ffff00') # yellow
#   gradient.addColorStop(0,'#ffffff') # white

#   # set new gradient as fill style
#   canvasContext.fillStyle = gradient

# drawTick = ->
#   tickData  = AudioService.getTick().getTickData()
#   threshold = 0

#   canvasContext.clearRect(0, 20, c.width, c.height)
#   maxBinCount = 3
#   space = 25

#   value = tickData.low
#   if value >= threshold
#     canvasContext.fillRect(5 + 0 * space, c.height - value, 15 , c.height)

#   value = tickData.mid
#   if value >= threshold
#     canvasContext.fillRect(5 + 1 * space, c.height - value, 15 , c.height)

#   value = tickData.high
#   if value >= threshold
#     canvasContext.fillRect(5 + 2 * space, c.height - value, 15 , c.height)

# updateTickVisualization = ->
#   drawTick()
#   rafID = window.requestAnimationFrame(updateTickVisualization)

# analyserReadyFunction = ->
#   initTickCanvas()

#   rafID = window.requestAnimationFrame(updateTickVisualization)

# if AudioService.getAnalyser().isReady()
#   analyserReadyFunction()
# else
#   AudioService.getAnalyser().on 'ready', analyserReadyFunction


# --------------------------------------------------------------------------------
# END tick
# --------------------------------------------------------------------------------










#
#
#
# CC=/usr/bin/cc CXX=/usr/bin/c++ npm install https://github.com/ZECTBynmo/node-core-audio.git --save
#
#
#
# coreAudio = require("node-core-audio")
# engine = coreAudio.createNewAudioEngine()


# buffer = engine.read()

# processAudio = (inputBuffer) ->
#   console.log "%d channels", inputBuffer.length
#   console.log "Channel 0 has %d samples", inputBuffer[0].length

#   inputBuffer

# engine.addAudioCallback processAudio


# clock = AudioService.getClock()

# tmpCounter = 0

# clock.on 'clock:tick', (c) ->
#   tmpCounter += 1

#   if tmpCounter >= 20
#     console.log '20 ticks'
#     tmpCounter = 0



# http://gizma.com/easing

# Math.functions = {}

# Math.functions.linearTween = (t, b, c, d) ->
#   return c*t/d + b

# Math.functions.easeInQuad = (t, b, c, d) ->
#   t /= d
#   return c*t*t + b

# Math.functions.easeOutQuad = (t, b, c, d) ->
#   t /= d
#   return -c * t*(t-2) + b

# Math.functions.easeInOutQuad = (t, b, c, d) ->
#   t /= d/2
#   return c/2*t*t + b if t < 1
#   t--
#   return -c/2 * (t*(t-2) - 1) + b

# Math.functions.easeInCubic = (t, b, c, d) ->
#   t /= d
#   return c*t*t*t + b

# Math.functions.easeOutCubic = (t, b, c, d) ->
#   t /= d
#   t--
#   return c*(t*t*t + 1) + b

# Math.functions.easeInOutCubic = (t, b, c, d) ->
#   t /= d/2
#   return c/2*t*t*t + b if t < 1
#   t -= 2
#   return c/2*(t*t*t + 2) + b

# Math.functions.easeInQuart = (t, b, c, d) ->
#   t /= d
#   return c*t*t*t*t + b

# Math.functions.easeOutQuart = (t, b, c, d) ->
#   t /= d
#   t--
#   return -c * (t*t*t*t - 1) + b

# Math.functions.easeInOutQuart = (t, b, c, d) ->
#   t /= d/2
#   return c/2*t*t*t*t + b if t < 1
#   t -= 2
#   return -c/2 * (t*t*t*t - 2) + b

# Math.functions.easeInQuint = (t, b, c, d) ->
#   t /= d
#   return c*t*t*t*t*t + b

# Math.functions.easeOutQuint = (t, b, c, d) ->
#   t /= d
#   t--
#   return c*(t*t*t*t*t + 1) + b

# Math.functions.easeInOutQuint = (t, b, c, d) ->
#   t /= d/2
#   return c/2*t*t*t*t*t + b if t < 1
#   t -= 2
#   return c/2*(t*t*t*t*t + 2) + b

# Math.functions.easeInSine = (t, b, c, d) ->
#   return -c * Math.cos(t/d * (Math.PI/2)) + c + b

# Math.functions.easeOutSine = (t, b, c, d) ->
#   return c * Math.sin(t/d * (Math.PI/2)) + b

# Math.functions.easeInOutSine = (t, b, c, d) ->
#   return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b

# Math.functions.easeInExpo = (t, b, c, d) ->
#   return c * Math.pow( 2, 10 * (t/d - 1) ) + b

# Math.functions.easeOutExpo = (t, b, c, d) ->
#   return c * ( -Math.pow( 2, -10 * t/d ) + 1 ) + b

# Math.functions.easeInOutExpo = (t, b, c, d) ->
#   t /= d/2
#   return c/2 * Math.pow( 2, 10 * (t - 1) ) + b if t < 1
#   t--
#   return c/2 * ( -Math.pow( 2, -10 * t) + 2 ) + b

# Math.functions.easeInCirc = (t, b, c, d) ->
#   t /= d
#   return -c * (Math.sqrt(1 - t*t) - 1) + b

# Math.functions.easeOutCirc = (t, b, c, d) ->
#   t /= d
#   t--
#   return c * Math.sqrt(1 - t*t) + b

# Math.functions.easeInOutCirc = (t, b, c, d) ->
#   t /= d/2
#   return -c/2 * (Math.sqrt(1 - t*t) - 1) + b if t < 1
#   t -= 2
#   return c/2 * (Math.sqrt(1 - t*t) + 1) + b









# ------------------------------------------------------------------------------------
# start
# ------------------------------------------------------------------------------------

# $ =>
#   # animation frame
#   rafID = null

#   # layout
#   LayoutView = require './views/layout_view'
#   layoutView = new LayoutView()

#   $('body').append(layoutView.$el)
#   layoutView.render()

#   # device - led bar
#   SohLedBar24ChDevice = require('./devices/soh_led_bar_24_ch/device')
#   led                 = new SohLedBar24ChDevice({ id: 'led-bar' })
#   ledSimulatorView    = led.getSimulatorView()
#   ledControlView      = led.getControlView()

#   ledSimulatorView.render()
#   ledControlView.render()

#   layoutView.ui.tabControls.append(ledSimulatorView.$el)
#   layoutView.ui.tabControls.append(ledControlView.$el)

#   window.requestAnimationFrame => ledControlView.triggerMethod 'attach'



#   # # --------------------------------------------------------------------------------
#   # # /// START animation test
#   # AbstractAnimation           = require('./devices/soh_led_bar_24_ch/animations/simple/abstract')
#   # animation1                  = new AbstractAnimation({ clock: AudioService.getClock() })
#   # SimpleWaveAnimation         = require('./devices/soh_led_bar_24_ch/animations/simple/simple_wave')
#   # animation2                  = new SimpleWaveAnimation({ clock: AudioService.getClock() })
#   # CenterWaveAnimation         = require('./devices/soh_led_bar_24_ch/animations/simple/center_wave')
#   # animation3                  = new CenterWaveAnimation({ clock: AudioService.getClock() })
#   # CollectorWaveAnimation      = require('./devices/soh_led_bar_24_ch/animations/simple/collector_wave')
#   # animation4                  = new CollectorWaveAnimation({ clock: AudioService.getClock() })
#   # SegmentTransitionAnimation  = require('./devices/soh_led_bar_24_ch/animations/simple/segment_transition')
#   # animation5                  = new SegmentTransitionAnimation({ clock: AudioService.getClock() })

#   # Programm1Animation          = require('./devices/soh_led_bar_24_ch/animations/programm_1')
#   # animation6                  = new Programm1Animation({ clock: AudioService.getClock() })


#   # # a = animation1
#   # # a = animation2
#   # # a = animation3
#   # # a = animation4
#   # # a = animation5
#   # a = animation6
#   # a.start()

#   # animationSwitchCounter = 0
#   # switchAnimationCheck = ->
#   #   if animationSwitchCounter >= 3
#   #     animationSwitchCounter = 0
#   #     a.stop()
#   #     a = if a == animation3 then animation2 else animation3
#   #     a.start()

#   #   animationSwitchCounter += 1

#   # animation2.on 'loop:finish', switchAnimationCheck
#   # animation3.on 'loop:finish', switchAnimationCheck

#   updateVisualization = ->
#     led.getControlConfig().setDmxValues(a.getData())
#     rafID = window.requestAnimationFrame(updateVisualization)
#   rafID = window.requestAnimationFrame(updateVisualization)
#   # /// END animation test
#   # --------------------------------------------------------------------------------





#   # 60fps = 17 ms
#   # 10fps = 100 ms

#   # setInterval =>
#   #   ledSimulatorView.render()
#   # , 100

#   # Model   = require 'devices/soh_led_bar_24_ch/models/control_config'
#   # SimView = require 'devices/soh_led_bar_24_ch/views/simulator/simulator_view'

#   # m = new Model()
#   # view = new SimView({ model: m })
#   # view.render()
#   # $('#tab-controls').append(view.$el)


#   # ---------------------------------------------------------------------------
#   # ---------------------------------------------------------------------------
#   # ---------------------------------------------------------------------------
#   # ---------------------------------------------------------------------------
#   # ---------------------------------------------------------------------------
#   # ---------------------------------------------------------------------------
#   # ---------------------------------------------------------------------------

#   # MidiNanoControlService = require 'services/midi/nano_control_service'

#   # class Test

#   #   _taktCounter: -1
#   #   _counter: -1
#   #   _speedCounter: 0

#   #   constructor: (model) ->
#   #     @model = model

#   #     @_speed = 1
#   #     @_r = 0
#   #     @_r_o = 0
#   #     @_g = 0
#   #     @_g_o = 0
#   #     @_b = 0
#   #     @_b_o = 0
#   #     @_freq = 1

#   #     MidiNanoControlService.on 'message', (message, deltaTime) =>
#   #       switch message[1]
#   #         when 0 then @_r = message[2] * 2
#   #         when 1 then @_g = message[2] * 2
#   #         when 2 then @_b = message[2] * 2

#   #         when 16 then @_r_o = message[2] / 127 * 2 * Math.PI
#   #         when 17 then @_g_o = message[2] / 127 * 2 * Math.PI
#   #         when 18 then @_b_o = message[2] / 127 * 2 * Math.PI

#   #         when 19 then @_freq = message[2] / 127 * Math.PI
#   #         when 20 then @_speed = message[2]



#   #   takt: =>
#   #     return
#   #     @_taktCounter += 1
#   #     return unless @_taktCounter >= @_speed
#   #     @_taktCounter = -1
#   #     @_counter += 1
#   #     # return unless @_counter == 20
#   #     # @_counter = 0

#   #     r = @taktR(@_counter)
#   #     g = @taktG(@_counter)
#   #     b = @taktB(@_counter)

#   #     @model.setDmxValues([
#   #       r[0], g[0], b[0],
#   #       r[1], g[1], b[1],
#   #       r[2], g[2], b[2],
#   #       r[3], g[3], b[3],
#   #       r[4], g[4], b[4],
#   #       r[5], g[5], b[5],
#   #       r[6], g[6], b[6],
#   #       r[7], g[7], b[7],
#   #     ])

#   #   taktR: (c) =>
#   #     value = @_r
#   #     c += @_r_o


#   #     [
#   #       parseInt((Math.sin(c + 0 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 1 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 2 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 3 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 4 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 5 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 6 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 7 * @_freq) + 1) / 2 * value),
#   #     ]

#   #   taktG: (c) =>
#   #     value = @_g
#   #     c += @_g_o

#   #     [
#   #       parseInt((Math.sin(c + 0 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 1 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 2 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 3 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 4 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 5 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 6 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 7 * @_freq) + 1) / 2 * value),
#   #     ]

#   #   taktB: (c) =>
#   #     value = @_b
#   #     c += @_b_o

#   #     [
#   #       parseInt((Math.sin(c + 0 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 1 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 2 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 3 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 4 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 5 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 6 * @_freq) + 1) / 2 * value),
#   #       parseInt((Math.sin(c + 7 * @_freq) + 1) / 2 * value),
#   #     ]

#   #     # @model.setDmxValues([
#   #     #   parseInt(m1 * color[0]), parseInt(m1 * color[1]), parseInt(m1 * color[2]),
#   #     #   parseInt(m2 * color[0]), parseInt(m2 * color[1]), parseInt(m2 * color[2]),
#   #     #   parseInt(m3 * color[0]), parseInt(m3 * color[1]), parseInt(m3 * color[2]),
#   #     #   parseInt(m4 * color[0]), parseInt(m4 * color[1]), parseInt(m4 * color[2]),
#   #     #   parseInt(m5 * color[0]), parseInt(m5 * color[1]), parseInt(m5 * color[2]),
#   #     #   parseInt(m6 * color[0]), parseInt(m6 * color[1]), parseInt(m6 * color[2]),
#   #     #   parseInt(m7 * color[0]), parseInt(m7 * color[1]), parseInt(m7 * color[2]),
#   #     #   parseInt(m8 * color[0]), parseInt(m8 * color[1]), parseInt(m8 * color[2]),
#   #     # ])

#   # # ---------------------------------------------------------------------------
#   # # ---------------------------------------------------------------------------
#   # # ---------------------------------------------------------------------------
#   # # ---------------------------------------------------------------------------
#   # # ---------------------------------------------------------------------------
#   # # ---------------------------------------------------------------------------
#   # # ---------------------------------------------------------------------------


#   # modi = new Test(m)
#   # setInterval =>
#   #   modi.takt()
#   #   # , 100
#   # , 17








# # global.artnet = require('artnet')({ host: '200.78.78.28' })

# # SohLedBar24H          = require './raw_device_control/soh_led_bar_24_ch'
# # SohLedBar24HProgramm  = require './device_programm/soh_led_bar_24_ch'

# # ledControl  = new SohLedBar24H()
# # programm    = new SohLedBar24HProgramm({ rawDevice: ledControl })

# # pos = 0

# # interval = setInterval =>
# #   programm.setProgramm(0)
# #   # programm.setProgramm(1)
# #   # programm.setProgramm(2)
# #   programm.bumpSequence()

# #   data = []
# #   # data = data.concat(ledControl.getData())
# #   data = data.concat([
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,
# #     255,

# #     50,
# #     50,
# #     50,
# #     0,

# #     200,
# #     120,
# #     0,
# #     100,
# #   ])

# #   # ledControl.setPower(0.1)
# #   # ledControl.setPower(Math.random())
# #   # ledControl.setLed(pos, [255, 0, 0, null])
# #   # pos += 1

# #   artnet.set 1, data
# # , 150







# # midi  = require('midi')
# # input = new midi.input()

# # console.log '-----'
# # console.log input.getPortCount()
# # console.log input.getPortName(0)


# # input.on 'message', (deltaTime, message) =>
# #   # The message is an array of numbers corresponding to the MIDI bytes:
# #   #   [status, data1, data2]
# #   # https://www.cs.cf.ac.uk/Dave/Multimedia/node158.html has some helpful
# #   # information interpreting the messages.
# #   console.log('m:' + message + ' d:' + deltaTime)

# # input.openPort(0)
# # input.ignoreTypes(false, false, false)
# # # input.closePort()



# # output = new midi.output()
# # output.openPort(0)
# # # output.sendMessage([x,y,z])


