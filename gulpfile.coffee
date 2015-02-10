gulp         = require 'gulp'
streamify    = require 'gulp-streamify'
uglify       = require 'gulp-uglify'
sketch       = require 'gulp-sketch'
cssimport    = require 'gulp-cssimport'
autoprefixer = require 'gulp-autoprefixer'
minifyCss    = require 'gulp-minify-css'
sourcemaps   = require 'gulp-sourcemaps'
browserify   = require 'browserify'
riotify      = require 'riotify'
source       = require 'vinyl-source-stream'
buffer       = require 'vinyl-buffer'
runSequence  = require 'run-sequence'
fs           = require 'fs'
path         = require 'path'
browserSync  = require 'browser-sync'
reload       = browserSync.reload

$ =
  dist:       './'
  images:     './images/'
  js:         './src/js/**/*.js'
  app:        './src/js/app.js'
  css:        './src/css/**/*.css'
  style:      './src/css/style.css'
  sitefiles:  './sitefiles/*.json'
  components: './src/components/*.tag'
  logo:       './src/images/logo.sketch'
  watch:      ['*.html', '*.js', '*.css']

sorter = (col, desc = false) ->
  sign = if desc then -1 else 1
  (a, b) ->
    return sign * 1    if a[col] > b[col]
    return sign * (-1) if a[col] < b[col]
    0

gulp.task 'default', (cb) -> runSequence 'create-index', [
  'browserify'
  'logo'
  'css'
], cb

gulp.task 'create-index', (cb) ->
  fs.readdir './sitefiles', (err, files) ->
    index = []
    for file in files when /\.json$/.test file
      sitefile = require "./sitefiles/#{file}"
      index.push
        id: sitefile.id
        title: sitefile.title
        url: sitefile.url
        language: sitefile.language
        origin: sitefile.origin or ''
    data = JSON.stringify index.sort sorter 'id'
    fs.writeFile 'index.json', data, -> cb()

gulp.task 'browserify', ->
  browserify
    entries: [$.app]
    debug: true
  .transform riotify
  .bundle()
  .pipe source path.basename $.app
  .pipe buffer()
  .pipe sourcemaps.init loadMaps: true
  .pipe streamify uglify()
  .pipe sourcemaps.write './'
  .pipe gulp.dest $.dist

gulp.task 'logo', ->
  gulp.src $.logo
  .pipe sketch
    export: 'artboards'
    formats: 'svg'
  .pipe gulp.dest $.images

gulp.task 'css', ->
  gulp.src $.style
  .pipe cssimport()
  .pipe autoprefixer 'last 2 versions'
  .pipe minifyCss keepSpecialComments: 0
  .pipe gulp.dest $.dist

gulp.task 'watch', ->
  browserSync.init
    notify: false
    server: baseDir: './'
  o = debounceDelay: 3000
  gulp.watch [$.sitefiles], o, ['create-index']
  gulp.watch [$.js, $.components], o, ['browserify']
  gulp.watch [$.css], o, ['css']
  gulp.watch [$.logo], o, ['logo']
  gulp.watch $.watch, o, reload
