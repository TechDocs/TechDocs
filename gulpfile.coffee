gulp        = require 'gulp'
runSequence = require 'run-sequence'
fs          = require 'fs'
path        = require 'path'

gulp.task 'default', (cb) -> runSequence 'create-index', cb

sorter = (col, desc = false) ->
  sign = if desc then -1 else 1
  (a, b) ->
    return sign * 1    if a[col] > b[col]
    return sign * (-1) if a[col] < b[col]
    0

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