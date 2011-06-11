/*
 * BlinkMuinoFade -- Fade up and down all BlinkM's LEDs.
 *
 * Based on the standard "Blink" Arduino example.
 * 
 * 2011 - Tod E. Kurt - http://todbot.com/blog/ - http://thingm.com/
 */

// BlinkM / BlinkM MinM pins
const int redPin = 3;  // 
const int grnPin = 4;  //
const int bluPin = 1;  // will blink when programming
const int sdaPin = 0;  // 'd' pin, can be digital I/O
const int sclPin = 2;  // 'c' pin, can be digital or analog I/O


void setup()
{
  pinMode(redPin, OUTPUT);     
  pinMode(grnPin, OUTPUT);     
  pinMode(bluPin, OUTPUT);     
}

void loop()
{
  // fade up
  for(byte i=1; i<100; i++) {
    byte on  = i;
    byte off = 100-on;
    for( byte j=0; j<100; j++ ) {
      digitalWrite(grnPin, HIGH);
      digitalWrite(bluPin, HIGH);
      delayMicroseconds(on);
      digitalWrite(grnPin, LOW);
      digitalWrite(bluPin, LOW);
      delayMicroseconds(off);
    }
  }
  // fade down
  for(byte i=1; i<100; i++) {
    byte on  = 100-i;
    byte off = i;
    for( byte j=0; j<100; j++ ) {
      digitalWrite(grnPin, HIGH);
      digitalWrite(bluPin, HIGH);
      delayMicroseconds(on);
      digitalWrite(grnPin, LOW);
      digitalWrite(bluPin, LOW);
      delayMicroseconds(off);
    }
  }
}


