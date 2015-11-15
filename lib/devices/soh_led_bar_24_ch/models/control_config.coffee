AbstractControlConfig = require '../../abstract/models/control_config'

module.exports = class SohLedBar24ChControlConfig extends AbstractControlConfig

  defaults:
    programm_type: 'manuell'
    programm: 0