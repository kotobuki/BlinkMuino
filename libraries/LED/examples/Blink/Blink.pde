#include <LED.h>

LED led(9, LED::SOURCE);

void setup() {
  led.blink(1000, 0, LED::TRIANGLE);
}

void loop() {
  led.update();
}
