#
# CC=/usr/bin/cc CXX=/usr/bin/c++ npm install midi --save
#


sass = require('node-sass')


jade = require('jade')
path = require('path')
fs = require('fs')
global.tpl = (dirname, relPath) ->
  jadeContent = fs.readFileSync(path.join(dirname, relPath), { encoding: 'utf8' })
  fn = jade.compile(jadeContent)

require './libs'

sass = require('node-sass')
style = sass.render({
  file: path.join(__dirname, '../stylesheets/main.sass')
}, (err, result) =>
  jQuery('head').append("<style media='all' rel='stylesheet'>#{result.css.toString()}</style>")
)







SohLedBar24ChDevice = require('./devices/soh_led_bar_24_ch/device')

led = new SohLedBar24ChDevice()

ledSimulatorView = led.getSimulatorView()

ledSimulatorView.render()

$('body').append(ledSimulatorView.$el)

# global.artnet = require('artnet')({ host: '200.78.78.28' })

# SohLedBar24H          = require './raw_device_control/soh_led_bar_24_ch'
# SohLedBar24HProgramm  = require './device_programm/soh_led_bar_24_ch'

# ledControl  = new SohLedBar24H()
# programm    = new SohLedBar24HProgramm({ rawDevice: ledControl })

# pos = 0

# interval = setInterval =>
#   programm.setProgramm(0)
#   # programm.setProgramm(1)
#   # programm.setProgramm(2)
#   programm.bumpSequence()

#   data = []
#   # data = data.concat(ledControl.getData())
#   data = data.concat([
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,
#     255,

#     50,
#     50,
#     50,
#     0,

#     200,
#     120,
#     0,
#     100,
#   ])

#   # ledControl.setPower(0.1)
#   # ledControl.setPower(Math.random())
#   # ledControl.setLed(pos, [255, 0, 0, null])
#   # pos += 1

#   artnet.set 1, data
# , 150







# midi  = require('midi')
# input = new midi.input()

# console.log '-----'
# console.log input.getPortCount()
# console.log input.getPortName(0)


# input.on 'message', (deltaTime, message) =>
#   # The message is an array of numbers corresponding to the MIDI bytes:
#   #   [status, data1, data2]
#   # https://www.cs.cf.ac.uk/Dave/Multimedia/node158.html has some helpful
#   # information interpreting the messages.
#   console.log('m:' + message + ' d:' + deltaTime)

# input.openPort(0)
# input.ignoreTypes(false, false, false)
# # input.closePort()



# output = new midi.output()
# output.openPort(0)
# # output.sendMessage([x,y,z])


