#include <Button.h>
#include <LED.h>

#include "Pins.h"

Button button = Button(sclPin);
LED led = LED(grnPin);

void setup() {

}

void loop() {
  button.update();

  if (button.uniquePress()) {
    led.fadeIn(50);
  } 
  else if (button.uniqueRelease()) {
    led.fadeOut(250);
  }

  led.update();
}

