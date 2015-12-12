module.exports = class CenterWaveAnimation extends require('./abstract')

  toCenter:   false
  speed:      0.25
  phase:      1
  delta:      2

  getLength: =>
    2 * Math.PI / @speed

  onTick: =>
    _.times 4, (i) =>
      modifier  = if @toCenter == true then 1 else -1

      val       = @_sinValue(modifier * @getTickCount() + i, @speed, @phase, @delta)
      @data[(i + 4) * 3 + 0] = val
      @data[(i + 4) * 3 + 1] = val
      @data[(i + 4) * 3 + 2] = val

      val       = @_sinValue(modifier * @getTickCount() + i, @speed, @phase, @delta)
      @data[(3 - i) * 3 + 0] = val
      @data[(3 - i) * 3 + 1] = val
      @data[(3 - i) * 3 + 2] = val

  _sinValue: (x, speed, phase, delta) =>
    val = (Math.sin(x * speed + phase - (Math.PI / 2)) + 1) * 0.5
    val = Math.pow(val, delta) * 255
    val = parseInt(val)

    if val < 0 then 0 else val
