#include <Button.h>
#include <LED.h>

#include "Pins.h"

Button button = Button(sclPin);
LED led = LED(grnPin);

void setup() {
  button.pressHandler(onPress);
  button.releaseHandler(onRelease);
  button.holdHandler(onHold, 1000);
}

void loop() {
  button.update();
  led.update();
}

void onPress(Button& b) {
  led.fadeIn(50);
}

void onRelease(Button& b) {
  led.fadeOut(250);
}

void onHold(Button& b) {
  led.blink(500);
}
