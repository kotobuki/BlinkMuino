/*
 * BlinkMuinoBlink3 -- Blink each of the BlinkM's LEDs one-by-one.
 *
 * Based on the standard "Blink" Arduino example.
 * 
 * 2011 - Tod E. Kurt - http://todbot.com/blog/ - http://thingm.com/
 */

// BlinkM / BlinkM MinM pins
const int redPin = 3;  // 
const int grnPin = 4;  //
const int bluPin = 1;  // PWM, will blink when programming
const int sdaPin = 0;  // PWM, 'd' pin, can be digital I/O
const int sclPin = 2;  // A/D, 'c' pin, can be digital I/O, or analog input

void setup() 
{
  pinMode(redPin, OUTPUT);
  pinMode(grnPin, OUTPUT);
  pinMode(bluPin, OUTPUT);
}

void loop() 
{
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
