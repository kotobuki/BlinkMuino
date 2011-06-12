#ifndef RGBLED_H
#define RGBLED_H

#if defined(ARDUINO) && ARDUINO >= 100
#include "Arduino.h"
#else
#include "WProgram.h"
#endif

#define COMMON_ANODE 0
#define COMMON_CATHODE 1

class RGBLED {
public:
	RGBLED(byte redPin, byte greenPin, byte bluePin, byte type = COMMON_ANODE);

	void goToColor(byte red, byte green, byte blue);
	void fadeToColor(byte red, byte green, byte blue, unsigned int time, bool synchronous = false);
	// void goToHSBColor(byte hue, byte saturation, byte brightness);
	// void fadeToHSBColor(byte hue, byte saturation, byte brightness, unsigned int time, bool synchronous = false);
	void update();

private:
	LED _redLED;
	LED _greenLED;
	LED _blueLED;
};

#endif