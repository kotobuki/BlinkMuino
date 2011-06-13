#include <LED.h>
#include <RGBLED.h>

// The pins of BlinkM
RGBLED rgbLED(3, 4, 1, COMMON_ANODE);

int hue = 0;

void setup() {

}

void loop() {
  // Convert from 0~359 to 0~255
  rgbLED.goToHSBColor(map(hue, 0, 359, 0, 255), 255, 255);

  hue = (hue + 1) % 360;
  delay(30);
}

