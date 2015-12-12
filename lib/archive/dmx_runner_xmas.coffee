#
# on error:
# "FtdiError: unable to claim usb device. Make sure the default FTDI driver is not in use (-5)"
#
# sudo kextunload -bundle-id com.FTDI.driver.FTDIUSBSerialDriver
# sudo kextload -bundle-id com.FTDI.driver.FTDIUSBSerialDriver
#




global.artnet = require('artnet')({ host: '127.0.0.1' })

# SohLedBar24H          = require './raw_device_control/soh_led_bar_24_ch'
# SohLedBar24HProgramm  = require './device_programm/soh_led_bar_24_ch'

# ledControl  = new SohLedBar24H()
# programm    = new SohLedBar24HProgramm({ rawDevice: ledControl })

# pos = 0

data = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255]

MidiNanoControlService = require 'services/midi/nano_control_service'
MidiNanoControlService.on 'message', (message, deltaTime) ->
  return unless _.isArray(message)
  return unless message[0] == 176
  # return unless message[1] >= 0 && message[1] <= 7
  return unless message[1] >= 0 && message[1] <= 6

  # data[message[1] + 6] = message[2] * 2
  # data[message[1] + 6] = 255 if data[message[1] + 6] >= 255
  data[message[1]] = message[2] * 2
  data[message[1]] = 255 if data[message[1] + 6] >= 255

_.each data, (d, i) =>
  data[i] = 1 if data[i] <= 0

interval = setInterval =>
  # programm.setProgramm(0)
  # programm.setProgramm(1)
  # programm.setProgramm(2)
  # programm.bumpSequence()

  # data = []
  # # data = data.concat(ledControl.getData())
  # data = data.concat([
  #   250,
  #   250,
  #   250,
  #   10,
  #   50,
  #   0,
  #   0,
  #   0,
  #   0,
  #   0,
  #   0,
  #   0,
  #   0,
  #   0,
  #   0,
  #   0,
  #   0,
  #   0,
  #   0,
  #   0,
  #   0,
  #   0,
  #   0,
  #   0,

  #   0,
  #   0,
  #   0,
  #   0,

  #   0,
  #   0,
  #   0,
  #   0,
  # ])

  # ledControl.setPower(0.1)
  # ledControl.setPower(Math.random())
  # ledControl.setLed(pos, [255, 0, 0, null])
  # pos += 1

  artnet.set 0, 1, data
, 50


