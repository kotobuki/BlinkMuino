#include "LED.h"

LED::LED() {

}

LED::LED(byte ledPin, byte driveMode) {
	init(ledPin, driveMode);
}

byte LED::square(float phase) {
	return (phase <= 0.5f) ? 255 : 0;
}

byte LED::triangle(float phase) {
	return (phase <= 0.5f) ? round(510.0f * phase) : round(510.0f * (1 - phase));
}

void LED::init(byte ledPin, byte driveMode) {
	_pin = ledPin;
	_driveMode = driveMode;
	_waveGenerator = square;
	pinMode(_pin, OUTPUT);
	off();
}

byte LED::getState(){
	return _status;
}

void LED::on(void) {
	_current = 255;

	if (_driveMode == SOURCE) {
		digitalWrite(_pin, HIGH);
	} else if (_driveMode == SYNC) {
		digitalWrite(_pin, LOW);
	}
	_status = ON;
}

void LED::off(void) {
	_current = 0;

	if (_driveMode == SOURCE) {
		digitalWrite(_pin, LOW);
	} else if (_driveMode == SYNC) {
		digitalWrite(_pin, HIGH);
	}
	_status = OFF;
}

void LED::toggle(void) {
	(_status == ON) ? off() : on();
}

void LED::blink(unsigned int time, byte times, byte wave, bool synchronous) {
	_cycle = time;
	_times = times;
	_status = BLINKING;
	_start = millis();

	if (wave == TRIANGLE) {
		_waveGenerator = triangle;
	} else {
		// this is the default wave
		_waveGenerator = square;
	}
}

//assume PWM
void LED::setValue(byte val) {
	_current = val;

	if (_driveMode == SOURCE) {
		analogWrite(_pin, val);
	} else if (_driveMode == SYNC) {
		analogWrite(_pin, 255 - val);
	}
}

byte LED::getValue() {
	return _current;
}

void LED::fadeTo(byte val, unsigned int time, bool synchronous) {
	_cycle = time;
	_times = 1;
	_status = IN_TRANSITION;
	_begin = _current;
	_end = val;
	_start = millis();

	if (!synchronous) {
		return;
	}

	while (_status == IN_TRANSITION) {
		update();
	}
}

//assume PWM
void LED::fadeIn(unsigned int time, bool synchronous) {
	fadeTo(255, time, synchronous);
}

//assume PWM
void LED::fadeOut(unsigned int time, bool synchronous) {
	fadeTo(0, time, synchronous);
}

void LED::update() {
	unsigned long elapsedTime = millis() - _start;

	if (_status == ON || _status == OFF) {
		return;
	}

	if (_times != 0 && (elapsedTime > (_cycle * _times))) {
		if (_status == BLINKING) {
			off();
		} else if (_status == IN_TRANSITION) {
			if (_current == 0) {
				_status = OFF;
			} else {
				_status = ON;
			}
		}
	} else {
		float phase = 0.0f;

		if (_status == BLINKING) {
			phase = (float)(elapsedTime % _cycle) / (float)_cycle;
			phase = constrain(phase, 0.0f, 1.0f);
			setValue(_waveGenerator(phase));
		} else if (_status == IN_TRANSITION) {
			phase = (float)(elapsedTime) / (float)_cycle;
			phase = constrain(phase, 0.0f, 1.0f);
			setValue(round(_begin + (float)(_end - _begin) * phase));
		}
	}
}