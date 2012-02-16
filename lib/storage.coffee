class Storage
  constructor: (@store, @request, @response) ->

  get: ->
    @response.writeHead(200)
    @response.end('ohai')

  post: ->
    2

  put: ->
    3

  delete: ->
    4

module.exports = Storage
