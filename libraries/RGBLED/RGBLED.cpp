#include "LED.h"
#include "RGBLED.h"

RGBLED::RGBLED(byte redPin, byte greenPin, byte bluePin, byte type) {
	byte driveMode = (type == COMMON_ANODE) ? SYNC : SOURCE;

	_redLED.init(redPin, driveMode);
	_greenLED.init(greenPin, driveMode);
	_blueLED.init(bluePin, driveMode);
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

void RGBLED::update() {
	_redLED.update();
	_greenLED.update();
	_blueLED.update();
}
