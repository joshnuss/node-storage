# Installation

Install dependencies with npm

```
npm link
```

Setup a configuration file ```config.json```, an example is provided

```
cp config.json.example config.json
```

# Development mode

Use *node-supervisor* to watch for changes to the coffeescripts and restart node

```
node-supervisor -e 'node|js|coffee' -x coffee -w lib,server.coffee server.coffee
```

# Operations

## creating a file

```
curl -X POST --data-binary @foo.jpg localhost:1337/foo.jpg
```

## updating a file

```
curl -X PUT --data-binary @foo.jpg localhost:1337/foo.jpg
```

## reading a file

```
curl localhost:1337/foo.txt
```

## deleting a file

```
curl -x DELETE localhost:1337/foo.txt
```
