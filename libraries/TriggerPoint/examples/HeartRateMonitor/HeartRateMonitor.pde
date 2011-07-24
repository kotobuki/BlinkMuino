/*
 A very simple heart rate monitor example

 The circuit:
 http://koress.jp/2010/05/arduinoap_shield.html

 Created 23 July 2011
 by Shigeru Kobayashi

 Modified 24 July 2011
 by Shigeru Kobayashi

 This example code is in the public domain.
 */

#include <TriggerPoint.h>

// the number of the heart rate sensor pin
const int sensorPin = A1;

// the number of the buzzer pin
const int buzzerPin = 12;

// the TriggerPoint object for the sensor pin
TriggerPoint triggerPoint = TriggerPoint(sensorPin);

void setup() {
  // set the pin mode of the buzzer pin
  pinMode(buzzerPin, OUTPUT);

  // define the threshold and hysteresis
  int threshold = 1023 / 4;
  int hysteresis = int((float)threshold * 0.05);

  // initialize the TriggerPoint object and set the event handler
  // for rising edge events
  triggerPoint.init(threshold, hysteresis);
  triggerPoint.risingEdgeHandler(onPulse);
}

void loop() {
  // update the TriggerPoint object
  triggerPoint.update();

  delay(10);
}

void onPulse() {
  // make a beep for each pulse
  digitalWrite(buzzerPin, HIGH);
  delay(50);
  digitalWrite(buzzerPin, LOW);
}

