module.exports = class SohLedBar24H extends require('./abstract')

  power: 1

  colorSet: [
    [0, 0, 0, null],
    [0, 0, 0, null],
    [0, 0, 0, null],
    [0, 0, 0, null],
    [0, 0, 0, null],
    [0, 0, 0, null],
    [0, 0, 0, null],
    [0, 0, 0, null],
  ]

  setPower: (val) =>
    @power = val

  setLed: (segments, color) =>
    return unless _.isArray(color)

    segments = [segments] unless _.isArray(segments)

    _.each segments, (index) =>
      return unless index >= 0 && index < 8
      @colorSet[index] = color

  getData: =>
    _.inject(@colorSet, (memo, color) =>
      power = color[3] || @power

      memo.concat [
        color[0] * power,
        color[1] * power,
        color[2] * power,
      ]
    , [])
