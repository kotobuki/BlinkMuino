#include <LED.h>
#include <RGBLED.h>

RGBLED rgbLED(3, 4, 1, COMMON_ANODE);

void setup() {

}

void loop() {
  rgbLED.fadeToColor(255, 0, 0, 1000, true);
  rgbLED.fadeToColor(0, 255, 0, 1000, true);
  rgbLED.fadeToColor(0, 0, 255, 1000, true);
}

