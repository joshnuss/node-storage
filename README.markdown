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

# Operations

## reading a file

```
curl localhost:1337/foo.txt
```

## deleting a file

```
curl -x DELETE localhost:1337/foo.txt
```
