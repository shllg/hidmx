module.exports = class SimulatorLayoutView extends Marionette.LayoutView

  template: tpl(__dirname, '../../templates/simulator/layout.jade')

  className: 'device-simulator soh_led_bar_24_ch'

  ui:
    unit1: '.led-unit-1'
    unit2: '.led-unit-2'
    unit3: '.led-unit-3'
    unit4: '.led-unit-4'
    unit5: '.led-unit-5'
    unit6: '.led-unit-6'
    unit7: '.led-unit-7'
    unit8: '.led-unit-8'

  modelEvents:
    'change': 'render'

  serializeData: =>
    name: 'SOH LED Bar 24 Ch'

  onRender: =>
    @.$el.attr('id', "simulator-#{@model.get('id')}")

    dmxValues = @model.getDMXValues()

    @ui.unit1.css('background-color', "rgb(#{dmxValues[0]},#{dmxValues[1]},#{dmxValues[2]})")
    @ui.unit2.css('background-color', "rgb(#{dmxValues[3]},#{dmxValues[4]},#{dmxValues[5]})")
    @ui.unit3.css('background-color', "rgb(#{dmxValues[6]},#{dmxValues[7]},#{dmxValues[8]})")
    @ui.unit4.css('background-color', "rgb(#{dmxValues[9]},#{dmxValues[10]},#{dmxValues[11]})")
    @ui.unit5.css('background-color', "rgb(#{dmxValues[12]},#{dmxValues[13]},#{dmxValues[14]})")
    @ui.unit6.css('background-color', "rgb(#{dmxValues[15]},#{dmxValues[16]},#{dmxValues[17]})")
    @ui.unit7.css('background-color', "rgb(#{dmxValues[18]},#{dmxValues[19]},#{dmxValues[20]})")
    @ui.unit8.css('background-color', "rgb(#{dmxValues[21]},#{dmxValues[22]},#{dmxValues[23]})")
