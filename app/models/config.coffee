module.exports = class Config extends Backbone.Model

  defaults:

    #
    # * Overall on/off switch
    # * on / off
    #
    mode: 'on'

    #
    # * unit is ticks
    # * 0 - no strobo
    # * 30 ticks ~90bpm
    # * 1 tick ~1200bpm
    #
    strobo: 0

    #
    # * Each device needs to decide on it's own, what the value means
    # * Values: auto, red, green, blue, warm, warmBright, bright, dark
    #
    colorScheme: 'auto'

    #
    # * Each device needs to decide on it's own, what the value means
    # * Meant as an intense value e.g. 0.25 could mean slow ambiente
    # * 0.0 - 1.0
    #
    power: 1.0

    #
    # * Each device needs to decide on it's own, what the value means
    # * How much is going on on the scene
    # * 0.0 - 1.0
    #
    speed: 1.0