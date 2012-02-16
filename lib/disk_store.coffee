fs = require('fs')
path = require('path')

ROOT = 'files'

fs.rm = (path, callback) ->
  require('child_process').exec("rm " + path, callback)

class DiskStore
  read: (uri, callback) ->
    @exists uri, (actual_path, exists) ->
      if exists
        stream = fs.createReadStream(actual_path) 
        stream.on 'error', (err) ->
          callback(err)

      callback(false, exists, stream)

  create: (uri, input, callback) ->
    @exists uri, (actual_path, exists) ->
      if exists
        callback(null, true)
      else
        stream = fs.createWriteStream(actual_path)
        stream.on 'error', (err) ->
          callback(err)
        input.pipe(stream)
        callback()

  delete: (uri, callback) ->
    @exists uri, (actual_path, exists) ->
      if exists
        fs.rm actual_path, (err) ->
          callback(err, exists)
      else
        callback()
  
  make_path: (uri) ->
    path.join(ROOT, uri)

  exists: (uri, callback) ->
    actual_path = @make_path(uri)

    path.exists actual_path, (exists) ->
      callback(actual_path, exists)

module.exports = DiskStore
