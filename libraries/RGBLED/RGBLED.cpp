#include "LED.h"
#include "RGBLED.h"

RGBLED::RGBLED(byte redPin, byte greenPin, byte bluePin, byte type) {
	byte driveMode = (type == COMMON_ANODE) ? SYNC : SOURCE;

	_redLED.init(redPin, driveMode);
	_greenLED.init(greenPin, driveMode);
	_blueLED.init(bluePin, driveMode);
}

// Reference
// Example code by Paul V.
// http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1235225449/13#13
void RGBLED::getRGB(byte hue, byte saturation, byte brightness, byte* r, byte* g, byte* b) {
	if (saturation == 0) {
		*r = *g = *b = brightness;
	} else {
		unsigned int scaledHue = (hue * 6);
		unsigned int sector = scaledHue >> 8;
		unsigned int offsetInSector = scaledHue - (sector << 8);
		unsigned int p = (brightness * (255 - saturation)) >> 8;
		unsigned int q = (brightness * (255 - ((saturation * offsetInSector) >> 8))) >> 8;
		unsigned int t = (brightness * (255 - ((saturation * (255 - offsetInSector)) >> 8))) >> 8;

		switch (sector) {
			case 0:
				*r = brightness;
				*g = t;
				*b = p;
				break;
			case 1:
				*r = q;
				*g = brightness;
				*b = p;
				break;
			case 2:
				*r = p;
				*g = brightness;
				*b = t;
				break;
			case 3:
				*r = p;
				*g = q;
				*b = brightness;
				break;
			case 4:
				*r = t;
				*g = p;
				*b = brightness;
				break;
			default:
				*r = brightness;
				*g = p;
				*b = q;
				break;
		}
	}
}

void RGBLED::goToColor(byte red, byte green, byte blue) {
	_redLED.setValue(red);
	_greenLED.setValue(green);
	_blueLED.setValue(blue);
}

void RGBLED::fadeToColor(byte red, byte green, byte blue, unsigned int time, bool synchronous) {
	_redLED.fadeTo(red, time);
	_greenLED.fadeTo(green, time);
	_blueLED.fadeTo(blue, time);

	if (!synchronous) {
		return;
	}

	while(_redLED.getState() == IN_TRANSITION) {
		_redLED.update();
		_greenLED.update();
		_blueLED.update();
	}
}

void RGBLED::goToHSBColor(byte hue, byte saturation, byte brightness) {
	byte red, green, blue;
	getRGB(hue, saturation, brightness, &red, &green, &blue);
	goToColor(red, green, blue);
}

void RGBLED::fadeToHSBColor(byte hue, byte saturation, byte brightness, unsigned int time, bool synchronous) {
	byte red, green, blue;
	getRGB(hue, saturation, brightness, &red, &green, &blue);
	fadeToColor(red, green, blue, time, synchronous);
}

void RGBLED::update() {
	_redLED.update();
	_greenLED.update();
	_blueLED.update();
}
