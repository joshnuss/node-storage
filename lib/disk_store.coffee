fs = require('fs')
path = require('path')

ROOT = 'files'

class DiskStore
  read: (uri, callback) ->
    actual_path = path.join(ROOT, uri)

    path.exists actual_path, (exists) ->
      stream = fs.createReadStream(actual_path) if exists
      callback(exists, stream)

module.exports = DiskStore
