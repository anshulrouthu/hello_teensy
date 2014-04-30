hello_teensy
============
A reference project for makefile based project on teensy3.0

Usage
-----

Run ./setup.sh 
when teensyduino installer starts click next and point it to the <current dir>/arduino-1.x.x/ folder and clocl next
select all the libraries that are required and click next ---> install

# ./setuo.sh
# cd blink
# make

this will load the built blink example into the teensy3.0 board


Note:
----
If you want to build for teensy3.1 change the occurances of *128* to 256 in the Makefile  
