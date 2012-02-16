# Development mode

You can use *node-supervisor* to watch for changes to the coffeescripts and restart node

```
node-supervisor -e 'node|js|coffee' -x coffee -w lib,server.coffee server.coffee
```
