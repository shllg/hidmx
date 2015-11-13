module.exports = class Abstract extends Marionette.Object

  currentSequence: 0

  currentProgramm: 0

  rawDevice: null

  initialize: (options) =>
    @rawDevice = options.rawDevice

  bumpSequence: =>
    @currentSequence += 1
    @currentSequence = 0 if @getSequencesCount() < @currentSequence

    @setSequenceData()
    @currentSequence

  setProgramm: (programmNumber) =>
    return unless @currentProgramm != programmNumber

    @currentProgramm = programmNumber
    @currentSequence = 0

  setSequenceData: =>
    # empty

  getSequencesCount: =>
    0