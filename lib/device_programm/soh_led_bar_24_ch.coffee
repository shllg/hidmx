module.exports = class SohLedBar24H extends require('./abstract')

  # currentSequence: 0
  # currentProgramm: 0
  # rawDevice: null

  getSequencesCount: =>
    switch @currentProgramm
      when 0 then 0
      when 1 then _.size(@getSequenceDataProgramm1()) - 1
      when 2 then _.size(@getSequenceDataProgramm2()) - 1
      else 0

  setSequenceData: =>
    switch @currentProgramm
      when 0 then return
      when 1 then @setSequenceDataProgramm1()
      when 2 then @setSequenceDataProgramm2()
      else return

  # ------------------------------------------------------
  setSequenceDataProgramm1: =>
    data = @getSequenceDataProgramm1()[@currentSequence]

    _.each data, (d) => @rawDevice.setLed(d[0], d[1])

  getSequenceDataProgramm1: =>
    return @_programm1 if _.isArray(@_programm1)

    @_programm1 = []
    offset      = 10
    segments    = 8

    counter     = 63
    speed       = 4

    _.times (counter + counter) + offset * segments, (count) => @_programm1.push([])

    _.times 8, (index) =>
      _.times counter, (count) =>
        @_programm1[count + index * offset].push [
          [index], [2 * count, 0, 0, null]
        ]
      _.times counter, (count) =>
        @_programm1[count + index * offset + counter].push [
          [index], [counter * speed - speed * count, 0, 0, null]
        ]

    @_programm1

  # ------------------------------------------------------
  setSequenceDataProgramm2: =>
    data = @getSequenceDataProgramm2()[@currentSequence]

    _.each data, (d) => @rawDevice.setLed(d[0], d[1])

  getSequenceDataProgramm2: =>
    return @_programm2 if _.isArray(@_programm2)

    @_programm2       = []
    @_programm2Matrix = [0, 0, 0, 0, 0.03, 0.15, 0.3, 0.8, 1, 0.8, 0.3, 0.15, 0.03, 0, 0, 0, 0]
    @_programm2Pos    = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]

    _.each @_programm2Pos, (index) =>
      i = @_programm2Pos[index]

      @_programm2.push [
        [[0], [parseInt(255 * @_programm2Matrix[i + 0]), 0, 0, null]],
        [[1], [parseInt(255 * @_programm2Matrix[i + 1]), 0, 0, null]],
        [[2], [parseInt(255 * @_programm2Matrix[i + 2]), 0, 0, null]],
        [[3], [parseInt(255 * @_programm2Matrix[i + 3]), 0, 0, null]],
        [[4], [parseInt(255 * @_programm2Matrix[i + 4]), 0, 0, null]],
        [[5], [parseInt(255 * @_programm2Matrix[i + 5]), 0, 0, null]],
        [[6], [parseInt(255 * @_programm2Matrix[i + 6]), 0, 0, null]],
        [[7], [parseInt(255 * @_programm2Matrix[i + 7]), 0, 0, null]],
      ]

    @_programm2
