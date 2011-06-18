#include <LED.h>
#include <RGBLED.h>

#include "Pins.h"

RGBLED rgbLED(redPin, grnPin, bluPin, COMMON_CATHODE);

int hue = 0;

void setup() {

}

void loop() {
  // Convert from 0~359 to 0~255
  rgbLED.goToHSBColor(map(hue, 0, 359, 0, 255), 255, 255);

  hue = (hue + 1) % 360;
  delay(30);
}

