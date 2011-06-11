// Reference
// LED library by Alexander Brevig

#ifndef LED_H
#define LED_H

#include "WProgram.h" 

#define SOURCE 0
#define SYNC 1

#define OFF 0
#define ON 1
#define BLINK 2
#define FADE_IN 3
#define FADE_OUT 4

class LED {
public:
	LED(uint8_t ledPin, byte driveMode = SOURCE);
	bool getState();
	void on();
	void off();
	void toggle();
	void blink(unsigned int time, byte times = 0, bool synchronous = false);
	void setValue(byte val);
	void fadeIn(unsigned int time, bool synchronous = false);
	void fadeOut(unsigned int time, bool synchronous = false);
	void update();

private:
	byte status;
	uint8_t pin;
	byte driveMode;
	unsigned long start;
	unsigned long cycle;
	unsigned int times;
};

extern LED DEBUG_LED;

#endif