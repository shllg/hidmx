module.exports = class SimpleWaveAnimation extends require('./abstract')

  backwards:  false
  speed:      0.5
  phase:      1
  delta:      1

  getLength: =>
    2 * Math.PI / @speed

  onTick: =>
    _.times 8, (i) =>
      modifier  = if @backwards == true then -1 else 1
      val       = @_sinValue(modifier * @getTickCount() + i, @speed, @phase, @delta)
      @data[i * 3 + 0] = val
      @data[i * 3 + 1] = val
      @data[i * 3 + 2] = val

  _sinValue: (x, speed, phase, delta) =>
    val = (Math.sin(x * speed + phase - (Math.PI / 2)) + 1) * 0.5
    val = Math.pow(val, delta) * 255
    val = parseInt(val)

    if val < 0 then 0 else val
