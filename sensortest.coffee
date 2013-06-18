Car = require("./4motorcar.coffee").Car
Car.init()
setTimeout =>
  Car.testdrive()
,12000
setTimeout =>
  console.log "4000"
,4000

Sensitive =
  sensors: {}
  init: (io) ->
    console.log "Sensitive init"
    that = this
    io.sockets.on "connection", (socket) ->
      for e of that.sensors
        socket.on e, that.sensors[e]

  emit: (e, data) ->
    k = []
    for key of data
      k.push key + ":" + data[key]
      #console.log "key: " + key
    if e = "orientation"
      #console.log e + " snelheid: " + data.b + " richting: " + data.g
      Car.drive(data.b, data.g)
    console.log e + "." + k.join("+") + "\n"
    
Sensitive.sensors.location = (data) ->
  precision = 6
  lat = Math.round(data.coords.latitude * Math.pow(10, precision)) / Math.pow(10, precision)
  lng = Math.round(data.coords.longitude * Math.pow(10, precision)) / Math.pow(10, precision)
  Sensitive.emit "location",
    lat: lat
    lng: lng


Sensitive.sensors.motion = (data) ->
  precision = 3
  x = Math.round(data.x * Math.pow(10, precision)) / Math.pow(10, precision)
  y = Math.round(data.y * Math.pow(10, precision)) / Math.pow(10, precision)
  z = Math.round(data.z * Math.pow(10, precision)) / Math.pow(10, precision)
  Sensitive.emit "motion",
    x: x
    y: y
    z: z


Sensitive.sensors.orientation = (data) ->
  precision = 1
  alpha = Math.round(data.alpha * Math.pow(10, precision)) / Math.pow(10, precision)
  beta = Math.round(data.beta * Math.pow(10, precision)) / Math.pow(10, precision)
  gamma = Math.round(data.gamma * Math.pow(10, precision)) / Math.pow(10, precision)
  Sensitive.emit "orientation",
    a: alpha
    b: beta
    g: gamma


Sensitive.sensors.compass = (data) ->
  precision = 1
  compass = Math.round(data.compass * Math.pow(10, precision)) / Math.pow(10, precision)
  direction = ""
  if data.compass <= 22.5 and data.compass >= 0 or data.compass <= 360 and data.compass >= 337.5
    direction = "N"
  else if data.compass <= 67.5 and data.compass > 22.5
    direction = "NE"
  else if data.compass <= 112.5 and data.compass > 67.5
    direction = "E"
  else if data.compass <= 157.5 and data.compass > 112.5
    direction = "SE"
  else if data.compass <= 202.5 and data.compass > 157.5
    direction = "S"
  else if data.compass <= 247.5 and data.compass > 202.5
    direction = "SW"
  else if data.compass <= 292.5 and data.compass > 247.5
    direction = "W"
  else direction = "NW"  if data.compass <= 337.5 and data.compass > 292.5
  Sensitive.emit "compass",
    degrees: compass
    direction: direction


exports.Sensitive = Sensitive
