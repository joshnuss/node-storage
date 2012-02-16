# Installation

Install dependencies with npm

```
npm link
```

# Development mode

Use *node-supervisor* to watch for changes to the coffeescripts and restart node

```
node-supervisor -e 'node|js|coffee' -x coffee -w lib,server.coffee server.coffee
```
