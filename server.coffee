http = require('http')
Storage = require('./lib/storage')
DiskStore = require('./lib/disk_store')

store = new DiskStore
storage = new Storage(store)

server = http.createServer (request, response) ->

  switch request.method  
    when 'GET'
      storage.get(request, response)
    when 'POST'
      storage.post(request, response)
    when 'PUT'
      storage.put(request, response)
    when 'DELETE'
      storage.delete(request, response)
    else
      response.writeHeader(501)
      response.end("Not implemented\n")

server.listen(1337)
