fs = require('fs')
path = require('path')
mkdirp = require('mkdirp')
configuration = require('nconf')

configuration.file(file: 'config.json')

fs.rm = (path, callback) ->
  require('child_process').exec("rm " + path, callback)

class DiskStore
  read: (uri, callback) ->
    @exists uri, (actual_path, found) ->
      if found
        fs.stat actual_path, (_, stats) ->
          stream = fs.createReadStream(actual_path) 
          stream.on 'error', (err) ->
            callback(err)

          callback(null, true, stream, stats.mtime)
      else
        callback()

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

  update: (uri, input, callback) ->
    @exists uri, (actual_path, found) ->
      if found
        stream = fs.createWriteStream(actual_path)
        stream.on 'error', (err) ->
          callback(err)

        stream.on 'close', ->
          callback(null,true)

        input.pipe(stream)
      else
        callback(null, false)

  delete: (uri, callback) ->
    @exists uri, (actual_path, found) ->
      if found
        fs.rm actual_path, (err) ->
          callback(err, found)
      else
        callback()
  
  make_path: (uri) ->
    path.join(configuration.get('storage_root'), uri)

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
