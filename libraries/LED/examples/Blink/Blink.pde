#include <LED.h>

LED led(3, SYNC);

void setup() {
  led.blink(1000, 0, TRIANGLE);
}

void loop() {
  led.update();
}
