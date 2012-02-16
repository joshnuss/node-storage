mime = require('mime')

class Storage
  constructor: (@store) ->

  get: (request, response) ->
    @store.read request.url, (err, exists, stream) ->
      if err
        response.writeHead(500)
        response.end("Server error\n")
      else if exists
        response.writeHead(200, 'Content-Type': mime.lookup(request.url)) 
        stream.pipe(response)
      else
        response.writeHead(404)
        response.end("Resource not found\n")

  post: (request, response) ->
    2

  put: (request, response) ->
    3

  delete: (request, response) ->
    4

module.exports = Storage
