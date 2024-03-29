mime = require('mime')

class Storage
  constructor: (@store) ->

  get: (request, response) ->
    self = this
    @store.read request.url, (err, found, stream, modified) ->
      if err
        self.handle_error(response)
      else if found
        modified_since = request.headers['if-modified-since']

        if modified_since && new Date(modified_since).getTime() == modified.getTime()
          response.writeHead(304)
          response.end('Not modified')
        else
          response.writeHead(200, 
                             'Content-Type': mime.lookup(request.url),
                             'Last-Modified': modified) 
          stream.pipe(response)
      else
        self.handle_missing(response)

  post: (request, response) ->
    self = this
    @store.create request.url, request, (err, found) ->
      if err
        self.handle_error(response)
      else if found
        response.writeHead(409)
        response.end("Resource already found\n")
      else
        response.writeHead(201)
        response.end("Resource created\n")

  put: (request, response) ->
    self = this
    @store.update request.url, request, (err, found) ->
      if err
        self.handle_error(response)
      else if found
        response.writeHead(200)
        response.end("Resource updated\n")
      else
        self.handle_missing(response)

  delete: (request, response) ->
    self = this
    @store.delete request.url, (err, found) ->
      if err
        self.handle_error(response)
      else if found
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
