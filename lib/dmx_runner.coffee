require('app-module-path').addPath(__dirname);

sass  = require('node-sass')
jade  = require('jade')
path  = require('path')
fs    = require('fs')

# import libraries
require './libs'

# external utils
global.FFT            = {}
global.FFT.fft        = require './libs/fft'
global.FFT.BeatDetect = require './libs/beatdetect'

# compile jade template function
global.tpl = (dirname, relPath) ->
  jadeContent = fs.readFileSync(path.join(dirname, relPath), { encoding: 'utf8' })
  fn = jade.compile(jadeContent)
  _.template(fn())

# underscore template interpolation
_.templateSettings = {
  interpolate: /\{\{=(.+?)\}\}/g,
  evaluate: /\{\{(.+?)\}\}/g,
}

# render style
style = sass.render({
  file: path.join(__dirname, '../stylesheets/main.sass')
  includePaths: [
    'bower_components/bourbon/app/assets/stylesheets'
  ]
}, (err, result) =>
  jQuery('head').append("<style media='all' rel='stylesheet'>#{result.css.toString()}</style>")
)

# run application
global.app = new (require('../app/app'))()
global.app.start()