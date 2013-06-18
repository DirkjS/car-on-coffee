app = require('express')()
server = require("http").createServer(app)
io = require("socket.io").listen(server)
Sensitive = require("./sensortest.coffee").Sensitive
Sensitive.init io
server.listen 8080
app.get "/", (req, res) ->
  res.sendfile __dirname + "/public/index.html"

app.get "/sensitive.js", (req, res) ->
  res.sendfile __dirname + "/public/js/sensitive.js"

