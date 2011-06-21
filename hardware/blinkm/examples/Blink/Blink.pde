#include "Pins.h"

void setup() {
  pinMode(redPin, OUTPUT);
  pinMode(grnPin, OUTPUT);
  pinMode(bluPin, OUTPUT);
}

void loop() {
  digitalWrite(redPin, HIGH);
  delay(500);
  digitalWrite(redPin, LOW);
  delay(500);

  digitalWrite(grnPin, HIGH);
  delay(500);
  digitalWrite(grnPin, LOW);
  delay(500);

  digitalWrite(bluPin, HIGH);
  delay(500);
  digitalWrite(bluPin, LOW);
  delay(500);
 
  delay(1000); 
}
