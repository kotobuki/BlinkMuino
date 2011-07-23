#include "TriggerPoint.h"

TriggerPoint::TriggerPoint(byte pin) {
	_pin = pin;
	_threshold = 0;
	_hysteresis = 0;
	_state = _lastState = -1;
	_risingEdgeEventHandler = NULL;
	_fallingEdgeEventHandler = NULL;

	pinMode(_pin, INPUT);
}

void TriggerPoint::init(int threshold, int hysteresis) {
	_threshold = threshold;
	_hysteresis = hysteresis;
}

void TriggerPoint::risingEdgeHandler(eventHandlerFunction eventHandler) {
	_risingEdgeEventHandler = eventHandler;
}

void TriggerPoint::fallingEdgeHandler(eventHandlerFunction eventHandler) {
	_fallingEdgeEventHandler = eventHandler;
}

void TriggerPoint::update() {
	_value = analogRead(_pin);

	_state = _lastState;

	if (_value < (_threshold - _hysteresis)) {
		_state = 0;
	}
	else if (_value > (_threshold + _hysteresis)) {
		_state = 1;
	}

	if ((_lastState == 0) && (_state != 0)) {
		if (_risingEdgeEventHandler != NULL) {
			(*_risingEdgeEventHandler)();
		}
	}
	else if ((_lastState != 0) && (_state == 0)) {
		if (_fallingEdgeEventHandler != NULL) {
			(*_fallingEdgeEventHandler)();
		}
	}

	_lastState = _state;
}
