#ifndef SET_POINT_H
#define SET_POINT_H

#if defined(ARDUINO) && ARDUINO >= 100
#include "Arduino.h"
#else
#include "WProgram.h"
#endif

extern "C" {
	typedef void (*eventHandlerFunction)(void);
}

class TriggerPoint {
public:
	TriggerPoint(byte pin);

	void init(int threshold, int hysteresis);

	void risingEdgeHandler(eventHandlerFunction eventHandler);
	void fallingEdgeHandler(eventHandlerFunction eventHandler);

	void update();

	inline int value() const { return _value; };

	inline int state() const { return _state; };

	inline int lastState() const { return _lastState; };

private:
	byte _pin;
	int _value;
	int _threshold;
	int _hysteresis;
	byte _state;
	byte _lastState;
	eventHandlerFunction _risingEdgeEventHandler;
	eventHandlerFunction _fallingEdgeEventHandler;
};

#endif