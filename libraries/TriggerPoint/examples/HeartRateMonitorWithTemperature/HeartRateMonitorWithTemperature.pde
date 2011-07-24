/*
 A heart rate monitor example with temperature sensor reporting
 
 The circuit:
 http://koress.jp/2010/05/arduinoap_shield.html
 
 Created 23 July 2011
 by Shigeru Kobayashi
 
 Modified 24 July 2011
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

// the buffer length
const int BUFFER_LENGTH = 5;

// the index of the middle
const int INDEX_OF_MIDDLE = BUFFER_LENGTH / 2;

// the ring buffer
int buffer[BUFFER_LENGTH];

void setup() {
  Serial.begin(9600); 

  // set the pin mode of the output pins
  pinMode(ledPin, OUTPUT);
  pinMode(buzzerPin, OUTPUT);

  // initialize the ring buffer
  for (int i = 0; i < BUFFER_LENGTH; i++) {
    buffer[i] = 60;
  }

  // define the threshold and hysteresis
  int threshold = 1023 / 4;
  int hysteresis = int((float)threshold * 0.05);

  triggerPoint.init(threshold, hysteresis);
  triggerPoint.risingEdgeHandler(onPulse);

  lastPulse = millis();
}

void loop() {
  // update the TriggerPoint object
  triggerPoint.update();

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
}

void onPulse() {
  unsigned long now = millis();
  unsigned long interval = now - lastPulse;

  // reject out of range values
  // supposed maximum BPM is 220 BPM (i.e. interval is 272ms)
  if (interval < 272) {
    return;
  }

  // update the BPM through the median filter
  bpm = smooth(round(1000.0 / (float)interval * 60.0));

  // make a beep
  digitalWrite(buzzerPin, HIGH);
  delay(50);
  digitalWrite(buzzerPin, LOW);

  lastPulse = now;
}

// smooth incoming values by a Median filter
int smooth(int raw) {
  // the index of the buffer to write
  static int index = 0;

  // the buffer for sorting
  static int sortBuffer[BUFFER_LENGTH];

  // write the raw value to the buffer
  buffer[index] = raw;

  // update the index for the next time
  index = (index + 1) % BUFFER_LENGTH;

  // copy to the buffer for sorting
  for (int i = 0; i < BUFFER_LENGTH; i++) {
    sortBuffer[i] = buffer[i];
  }

  // do quick sort
  qsort(sortBuffer, BUFFER_LENGTH, sizeof(int),
  comparisonFunction);

  // return the middle value
  return sortBuffer[INDEX_OF_MIDDLE];
}

// the comparion function for quick sorting
int comparisonFunction(const void *a, const void *b) {
  int _a = *(int *)a;
  int _b = *(int *)b;
  if (_a < _b) {
    // return -1 if a < b
    return -1;
  } 
  else if (_a > _b) {
    // return 1 if a > b
    return 1;
  } 
  else {
    // return 0 if a == b
    return 0;
  }
}

