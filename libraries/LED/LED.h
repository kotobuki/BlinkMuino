// Reference
// LED library by Alexander Brevig

#ifndef LED_H
#define LED_H

#if defined(ARDUINO) && ARDUINO >= 100
#include "Arduino.h"
#else
#include "WProgram.h"
#endif

class LED;

extern "C" {
	typedef byte(*WAVE_GENERATOR)(float phase);
}

class LED {
public:
	enum {
		SOURCE,
		SYNC,
		OFF,
		ON,
		BLINKING,
		IN_TRANSITION,
		SQUARE,
		TRIANGLE
	};

	LED();
	LED(byte ledPin, byte driveMode = SOURCE);

	static byte square(float phase);
	static byte triangle(float phase);

	void init(byte ledPin, byte driveMode = SOURCE);
	byte getState();
	void on();
	void off();
	void toggle();
	void blink(unsigned int time, byte times = 0, byte wave = 0, bool synchronous = false);
	void setValue(byte val);
	byte getValue();
	void fadeTo(byte val, unsigned int time, bool synchronous = false);
	void fadeIn(unsigned int time, bool synchronous = false);
	void fadeOut(unsigned int time, bool synchronous = false);
	void update();

private:
	byte _status;
	byte _pin;
	byte _driveMode;
	byte _current;
	byte _begin;
	byte _end;

	unsigned long _start;
	unsigned long _cycle;
	unsigned int _times;

	WAVE_GENERATOR _waveGenerator;
};

#endif