AbstractControlConfig = require '../../abstract/models/control_config'

module.exports = class SohLedBar24ChControlConfig extends AbstractControlConfig

  defaults:
    id:             null
    programm_type:  'manuell'
    programm:       0

  # getDMXValues: =>
  #   [
  #     255, parseInt(Math.random()*255), 255,
  #     255, parseInt(Math.random()*255), 255,
  #     255, parseInt(Math.random()*255), 255,
  #     255, parseInt(Math.random()*255), 255,
  #     255, parseInt(Math.random()*255), 255,
  #     255, parseInt(Math.random()*255), 255,
  #     255, parseInt(Math.random()*255), 255,
  #     255, parseInt(Math.random()*255), 255,
  #   ]


  getDMXValues: =>
    @_dmxValues or= [
      0,0,0,
      0,0,0,
      0,0,0,
      0,0,0,
      0,0,0,
      0,0,0,
      0,0,0,
      0,0,0,
    ]

  setDmxValues: (arr) =>
    @_dmxValues = arr
    @trigger 'change'