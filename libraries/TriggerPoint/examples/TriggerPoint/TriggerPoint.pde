#include <TriggerPoint.h>

int threshold = 511;
int hysteresis = 102;

int sensorPin = 0;
int ledPin = 13;

TriggerPoint triggerPoint = TriggerPoint(sensorPin);

void setup() {
  pinMode(ledPin, OUTPUT);

  triggerPoint.init(threshold, hysteresis);
  triggerPoint.risingEdgeHandler(onBrightenUp);
  triggerPoint.fallingEdgeHandler(onDarkenUp);
}

void loop() {
  triggerPoint.update();

  delay(100);
}

void onBrightenUp() {
  digitalWrite(ledPin, LOW);
}

void onDarkenUp() {
  digitalWrite(ledPin, HIGH);
}
