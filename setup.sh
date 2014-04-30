#!/bin/sh

wget http://arduino.googlecode.com/files/arduino-1.0.5-linux32.tgz
tar xvzf arduino-1.0.5-linux32.tgz
rm arduino-1.0.5-linux32.tgz

wget https://www.pjrc.com/teensy/td_118/teensyduino.32bit
chmod +x teensyduino.32bit
./teensyduino.32bit
rm teensyduino.32bit
