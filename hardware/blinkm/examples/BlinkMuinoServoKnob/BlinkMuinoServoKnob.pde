/*
 * BlinkMuinoServoKnob -- Control a servo with a knob 
 *
 *
 * 
 * 2011 - Tod E. Kurt - http://todbot.com/blog/ - http://thingm.com/
 */

// BlinkM / BlinkM MinM pins
const int redPin = 3;  // 
const int grnPin = 4;  //
const int bluPin = 1;  // PWM, will blink when programming
const int sdaPin = 0;  // PWM, 'd' pin, can be digital I/O
const int sclPin = 2;  // A/D, 'c' pin, can be digital I/O, or analog input


const int servoPin = sdaPin;
const int knobPin  = sclPin;

int pos;
int pulseWidth;

void setup() 
{
  pinMode(redPin, OUTPUT);
  pinMode(grnPin, OUTPUT);
  pinMode(bluPin, OUTPUT);

  pinMode(servoPin, OUTPUT);
  pinMode(knobPin, INPUT);
  
  digitalWrite(grnPin, HIGH);     // do a little "hello there" intro
  delay(100);
  digitalWrite(grnPin, LOW); 
}

void loop() 
{
  digitalWrite(redPin, HIGH);     // say we're doing something

  pos = analogRead( knobPin ); // ranges from 0-1024

  analogWrite( bluPin, pos/4 );

  pulseWidth = pos + 1000;    // convert to microseconds pulsewidth

  digitalWrite(servoPin, HIGH);   // make servo pulse
  delayMicroseconds(pulseWidth);
  digitalWrite(servoPin, LOW);

  digitalWrite(redPin, LOW);      // say we're done

  delay(20);
  

}
