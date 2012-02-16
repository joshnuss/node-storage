http = require('http')
Storage = require('./lib/storage')
DiskStore = require('./lib/disk_store')

store = new DiskStore

server = http.createServer (request, response) ->
  storage = new Storage(store, request, response)

  switch request.method  
    when 'GET'
      storage.get()
    when 'POST'
      storage.post()
    when 'PUT'
      storage.put()
    when 'DELETE'
      storage.delete()

server.listen(1337)
