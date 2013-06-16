# DDRV8835 motordriver
# pin 2 phase A motor blue/white
# pin 3 enable PWM A
# pin 4 phase B motor red/white
# pin 5 enable PWM B
# pin 6 enable PWM A
# pin 7 phase A motor yellow/white
# pin 8 phase B motor brown/white
# pin 9 enable PWM B
#

firmata = require("firmata")
board = undefined
pin2 = 2
pin3 = 3
pin4 = 4
pin5 = 5
pin6 = 6
pin7 = 7
pin8 = 8
pin9 = 9
ledPin = 13
ledPWM = 10
ledLow = 12

Car =
  init: ->
    console.log "Car.init"
    board = new firmata.Board("/dev/tty.usbserial-A6001UQ8",  (err) ->
      if err
        console.log err
        return
      
      console.log 'connected'
      console.log 'Firmware: ' + board.firmware.name + '-' + board.firmware.version.major + '.' + board.firmware.version.minor
      ledOn = true
      board.pinMode ledPin, board.MODES.OUTPUT
      board.pinMode ledPWM, board.MODES.PWM
      board.pinMode ledLow, board.MODES.OUTPUT
      board.digitalWrite ledLow, board.LOW

      board.pinMode pin2, board.MODES.OUTPUT
      board.pinMode pin3, board.MODES.PWM
      board.pinMode pin4, board.MODES.OUTPUT
      board.pinMode pin5, board.MODES.PWM
      board.pinMode pin6, board.MODES.PWM
      board.pinMode pin7, board.MODES.OUTPUT
      board.pinMode pin8, board.MODES.OUTPUT
      board.pinMode pin9, board.MODES.PWM
      setInterval =>
        if ledOn
          board.digitalWrite ledPin, board.HIGH
          board.analogWrite ledPWM, 50
        else
          board.digitalWrite ledPin, board.LOW
          board.analogWrite ledPWM, 200
        ledOn = !ledOn
      ,1000)
      #true

  testdrive : ->
    console.log "testdrive"
    Car.flMotor 50, board.HIGH
    Car.frMotor 50, board.HIGH
    Car.blMotor 50, board.HIGH
    Car.brMotor 50, board.HIGH
    setTimeout =>
      Car.flMotor 0, board.LOW
      Car.frMotor 0, board.LOW
      Car.blMotor 0, board.LOW
      Car.brMotor 0, board.LOW
    ,1000

  drive: (speed, direction) ->
    if direction > 6 or direction < -6
      d = direction/45
      if direction > 45
        d = 1
      else if direction < -45
        d = -1
    else
      d = 0
    if speed > 6
      v = speed/45
      if speed > 45
        v = 1
      direction = board.HIGH
    else if speed < -6
      v =  -speed/45
      if speed < -45
        v = 1
      direction = board.LOW
    else v = 0
    if d > 0
      vleft = parseInt (v)*200
      vright = parseInt (v-d)*200
    else if d < 0
      vleft = parseInt (v+d)*200
      vright = parseInt v*200
    else
      vleft = parseInt v*200
      vright = parseInt v*200

    Car.flMotor vleft, direction
    Car.frMotor vright, direction
    Car.blMotor vleft, direction
    Car.brMotor vright, direction
    console.log "speed vl: " + vleft + " vr: " + vright + " direction: " + d


Car.flMotor = (speed, direction) ->
  console.log "fl " + speed + " " + direction
  board.digitalWrite pin7, direction
  board.analogWrite pin6, speed

Car.frMotor = (speed, direction) ->
  console.log "fr " + speed + " " + direction
  board.digitalWrite pin8, direction
  board.analogWrite pin9, speed

Car.blMotor = (speed, direction) ->
  board.digitalWrite pin2, direction
  board.analogWrite pin3, speed

Car.brMotor = (speed, direction) ->
  board.digitalWrite pin4, direction
  board.analogWrite pin5, speed

exports.Car = Car
