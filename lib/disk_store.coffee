fs = require('fs')
path = require('path')
mkdirp = require('mkdirp')

ROOT = 'files'

fs.rm = (path, callback) ->
  require('child_process').exec("rm " + path, callback)

class DiskStore
  read: (uri, callback) ->
    @exists uri, (actual_path, found) ->
      if found
        stream = fs.createReadStream(actual_path) 
        stream.on 'error', (err) ->
          callback(err)

      callback(false, found, stream)

  create: (uri, input, callback) ->
    self = this
    @ensure_directory uri, ->
      self.exists uri, (actual_path, found) ->
        if found
          callback(null, true)
        else
          stream = fs.createWriteStream(actual_path)
          stream.on 'error', (err) ->
            callback(err)

          stream.on('close', callback)

          input.pipe(stream)

  delete: (uri, callback) ->
    @exists uri, (actual_path, found) ->
      if found
        fs.rm actual_path, (err) ->
          callback(err, found)
      else
        callback()
  
  make_path: (uri) ->
    path.join(ROOT, uri)

  exists: (uri, callback) ->
    actual_path = @make_path(uri)

    path.exists actual_path, (found) ->
      callback(actual_path, found)

  ensure_directory: (uri, callback) ->
    dirname = path.dirname(uri)

    @exists dirname, (actual_path, found) ->
      if found
        callback()
      else
        mkdirp(actual_path, 0700, callback)

module.exports = DiskStore
