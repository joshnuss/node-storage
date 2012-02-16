mime = require('mime')

class Storage
  constructor: (@store) ->

  get: (request, response) ->
    self = this
    @store.read request.url, (err, exists, stream) ->
      if err
        self.handle_error(response)
      else if exists
        response.writeHead(200, 'Content-Type': mime.lookup(request.url)) 
        stream.pipe(response)
      else
        self.handle_missing(response)

  post: (request, response) ->
    2

  put: (request, response) ->
    3

  delete: (request, response) ->
    self = this
    @store.delete request.url, (err, exists) ->
      if err
        self.handle_error(response)
      else if exists
        response.writeHead(200)
        response.end("Resource deleted\n")
      else
        self.handle_missing(response)

  handle_error: (response) ->
    response.writeHead(500)
    response.end("Server error\n")
    
  handle_missing: (response) ->
    response.writeHead(404)
    response.end("Resource not found\n")

module.exports = Storage
