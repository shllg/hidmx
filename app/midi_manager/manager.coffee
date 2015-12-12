module.exports = class MidiManager extends Marionette.Object

  env: null

  initialize: (options) =>
    @env = options.env