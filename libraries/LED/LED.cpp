#include "LED.h"

LED::LED(uint8_t ledPin, byte driveMode) {
	this->pin = ledPin;
	this->status = OFF;
	this->driveMode = driveMode;
	pinMode(this->pin, OUTPUT);

	if (driveMode == SOURCE) {
		digitalWrite(pin, LOW);
	} else if (driveMode == SYNC) {
		digitalWrite(pin, HIGH);
	}
}

bool LED::getState(){ return status; }

void LED::on(void) {
	if (driveMode == SOURCE) {
		digitalWrite(pin, HIGH);
	} else if (driveMode == SYNC) {
		digitalWrite(pin, LOW);
	}
	this->status = ON;
}

void LED::off(void) {
	if (driveMode == SOURCE) {
		digitalWrite(pin, LOW);
	} else if (driveMode == SYNC) {
		digitalWrite(pin, HIGH);
	}
	this->status = OFF;
}

void LED::toggle(void) {
	(status == ON) ? off() : on();
}

void LED::blink(unsigned int time, byte times, bool synchronous) {
	this->cycle = time;
	this->times = times;
	this->status = BLINK;
	this->start = millis();
}

//assume PWM
void LED::setValue(byte val) {
	if (driveMode == SOURCE) {
		analogWrite(pin, val);
	} else if (driveMode == SYNC) {
		analogWrite(pin, 255 - val);
	}
}

//assume PWM
void LED::fadeIn(unsigned int time, bool synchronous) {
	this->cycle = time;
	this->times = 1;
	this->status = FADE_IN;
	this->start = millis();
}

//assume PWM
void LED::fadeOut(unsigned int time, bool synchronous) {
	this->cycle = time;
	this->times = 1;
	this->status = FADE_OUT;
	this->start = millis();
}

void LED::update() {
	unsigned long now = millis();
	unsigned long elapsedTime = now - start;

	if (status == ON || status == OFF) {
		return;
	}

	if (times != 0 && (elapsedTime > (this->cycle * times))) {
		switch (status) {
			case BLINK:
				off();
				break;
			case FADE_IN:
				on();
				break;
			case FADE_OUT:
				off();
				break;
			default:
				break;
		}
	} else {
		float phase = (float)(elapsedTime % this->cycle) / (float)this->cycle;
		if (phase < 0.0f) {
			phase = 0.0f;
		} else if (phase > 1.0f) {
			phase = 1.0f;
		}
		switch (status) {
			case BLINK:
				if (phase < 0.5f) {
					setValue(255);
				} else {
					setValue(0);
				}
				break;
			case FADE_IN:
				setValue(round(255.0f * phase));
				break;
			case FADE_OUT:
				setValue(255 - round(255.0f * phase));
				break;
			default:
				break;
		}
	}
}