car-on-coffee
=============

Car with arduino &amp; firmata driven by phone and coffeescript

Just an experiment to use sensor data from a phone to drive a four motor car. The arduino drives four motors with two pololu DDRV8853 motordrivers. On the arduino [firmata](https://github.com/jgautier/firmata) is loaded. The app.coffee starts a server to read the sensor data on an iPhone or iPad. This is all based on [sensitive-arduino](https://github.com/alanreid/Sensitive-Arduino) from Alan Reid.  

###To use it: 

Get the source: 
'''
git clone git@github.com:DirkjS/car-on-coffee.git
cd car-on-coffee
npm install
'''

Change the serialport to whatever your system uses. Load firmata on an arduino. Wire the motordrivers as described in 4motorcar.coffee. Start it up with 
'''
coffee app.coffee
'''
There is a timeout to wait for the firmata connection. There is probably a better way of doing this. Access the node ip address at port 8080 and choose the orientation sensor. The connection should in the terminal and after choosing the orientation sensor the motors should start running, unless the phone or ipad is complete horizontal. 

###Contact 
On twitter: [3DirkJS](https://twitter.com/3DirkJS)

### License
This software is distributed under the Apache 2.0 License: http://www.apache.org/licenses/LICENSE-2.0

