/*
 A heart rate monitor example with temperature sensor reporting

 The circuit:
 http://koress.jp/2010/05/arduinoap_shield.html

 Created 23 July 2011
 by Shigeru Kobayashi

 This example code is in the public domain.
 */

#include <TriggerPoint.h>

// the number of the temperature sensor pin
const int tempSensorPin = A0;

// the number of the heart rate sensor pin
const int heartRateSensorPin = A1;

// the number of the buzzer pin
const int buzzerPin = 12;

// the number of the LED pin
const int ledPin = 13;

const int B = 3975; 

// the TriggerPoint object for the sensor pin
TriggerPoint triggerPoint = TriggerPoint(heartRateSensorPin);

// the time of the last pulse
unsigned long lastPulse = 0;

// the next time to report sensor values
unsigned long nextReportMillis = 0;

// best per minute
float bpm = 60;

void setup() {
  Serial.begin(9600); 

  // set the pin mode of the output pins
  pinMode(ledPin, OUTPUT);
  pinMode(buzzerPin, OUTPUT);

  // wait for 1 second and update the maximum value
  int maximum = 0;
  while (millis() < 1000) {
    maximum = max(analogRead(heartRateSensorPin), maximum);
  }

  int threshold = int((float)maximum * 0.8);
  int hysteresis = int((float)maximum * 0.05);

  triggerPoint.init(threshold, hysteresis);
  triggerPoint.risingEdgeHandler(onPulse);

  lastPulse = millis();
}

void loop() {
  // update the TriggerPoint object
  triggerPoint.update();

  unsigned long now = millis();

  // if it's not time to report, skip followings
  if (now < nextReportMillis) {
    return;
  }
  nextReportMillis = now + 1000;

  // read the temperature
  int sensorValue = analogRead(tempSensorPin);            

  // map it to the range of the analog out
  float resistance=(float)(1023-sensorValue)*10000/sensorValue; 
  float temperature=1/(log(resistance/10000)/B+1/298.15)-273.15;

  // print the results to the serial monitor:
  Serial.print("Temp:");
  Serial.println(temperature);   

  Serial.print("BPM:");
  Serial.println(bpm);   

  // if any command from the PC is availbale, handle the commands
  if (Serial.available() > 0) {
    int incomingByte = Serial.read();
    if (incomingByte == 1){
      digitalWrite(13, HIGH);
    }
    else{
      digitalWrite(13, LOW);
    }
  }
}

void onPulse() {
  unsigned long now = millis();
  unsigned long interval = now - lastPulse;

  bpm = 1000.0 / (float)interval * 60.0;

  // make a beep
  digitalWrite(buzzerPin, HIGH);
  delay(50);
  digitalWrite(buzzerPin, LOW);

  lastPulse = now;
}

