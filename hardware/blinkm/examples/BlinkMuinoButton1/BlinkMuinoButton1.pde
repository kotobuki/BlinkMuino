#include <Button.h>
#include <LED.h>

#include "Pins.h"

Button button = Button(sclPin);
//Button button2 = Button(sdaPin);

LED led = LED(grnPin);
//LED led2 = LED(redPin);

void setup() {

}

void loop() {
  if (button.isPressed()) {
    led.on();
  } 
  else {
    led.off();
  }

//  if (button2.isPressed()) {
//    led2.on();
//  } 
//  else {
//    led2.off();
//  }
}

