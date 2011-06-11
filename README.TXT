BlinkMuino -- Small Arduino on an BlinkM using ATtiny85/ATtiny45
==========
2011 - Tod E. Kurt - http://todbot.com/blog/ - http://thingm.com/

BlinkM and BlinkM MinM Smart LEDs can be used as a tiny Arduino.
Or AVR ATtiny85/45 dev board.


Capabilities
------------
- 0.4" square (MinM), or 0.62" square (BlinkM)
- 8MHz clock speed
- 3 high-brightness LEDs: red, green, & blue
- 2 digital I/O lines 
- 1 analog I/O line  (shared with digital)
- 8k bytes Flash ROM (4kB on ATtiny45)
- 512 bytes RAM      (256 bytes on ATtiny45)
- 512 bytes EEPROM   (256 bytes on ATtiny45)


Pin out
-------
Description - Arduino pin -  ATtiny85 pin 
-----------   -----------    ------------
red LED         3             PBx
grn LED         4             PBx
blu LED         1             PBx
SDA pin, digital I/O          0             PBx
SCL pin, analog & digital I/O         2             PBx 


Hardware Setup
--------------
You will need an AVR-ISP programmer to program the BlinkM boards.
If you have an Arduino board, the ArduinoISP sketch turns the Arduino 
into an AVR-ISP programmer.  However, it doesn't work for all Arduino boards.
Or you can use real AVR-ISP programmer.  These are fairly low-cost:
the official AVRISPmkII from Atmel is 35 USD, while the USBtinyISP is 22 USD.

With a programmer acquired, wire up the BlinkM to it.  If using AruinoISP, 
see the diagrams and photos here:
  http://code.google.com/p/blinkm-projects/wiki/ReflashBlinkM
If using a regular AVR-ISP programmer, see the wiring diagrams here:
  http://code.google.com/p/blinkm-projects/wiki/BlinkMuino


Software Installation
---------------------
1. Copy the "hardware" in this folder to your Arduino sketchbook folder.

You can find the location of your sketchbook by opening the Arduino preferences
and looking at the "Sketchbook location" field.
(If you already have a "hardware" folder in your sketchbook folder, copy
just the "blinkm" folder into it)

2. Restart the Arduino software.

3. The "Tools" -> "Board" menu should now have entries for BlinkMs. 
Select the entry that is correct for your hardware.


Use
---
Open up one of the example sketches in hardware/blinkm/examples, say the
"BlinkMuinoBlink3" sketch.  Click the Run button to test compile it.

Make sure your BlinkM is connected to the programmer and click "Upload".
If you have problems, press the Shift key while clicking Upload to see verbose
messages.



Links
-----
- ReflashBlinkM
-- http://code.google.com/p/blinkm-projects/wiki/ReflashBlinkM

- Arduino core for ATtiny45/85
-- http://hlt.media.mit.edu/wiki/pmwiki.php?n=Main.ArduinoATtiny4585

- Arduino core for ATtiny45/85
-- http://sites.google.com/site/elettronicaarduinoesperimenti/Home/arduino-ide-and-attiny45

- ArduinoISP
-- http://arduino.cc/en/Tutorial/ArduinoISP

- AVRISP mkII 
-- http://search.digikey.com/scripts/DkSearch/dksus.dll?Cat=2621880&k=avrisp

- USBtinyISP
-- http://www.adafruit.com/index.php?main_page=product_info&cPath=16&products_id=46

- BlinkM datasheet
-- http://thingm.com/fileadmin/thingm/downloads/BlinkM_datasheet.pdf