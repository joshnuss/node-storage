fs = require('fs')
path = require('path')

ROOT = 'files'

class DiskStore
  read: (uri, callback) ->
    actual_path = path.join(ROOT, uri)

    path.exists actual_path, (exists) ->
      if exists
        stream = fs.createReadStream(actual_path) 
        stream.on 'error', (err) ->
          callback(err)

      callback(false, exists, stream)


module.exports = DiskStore
