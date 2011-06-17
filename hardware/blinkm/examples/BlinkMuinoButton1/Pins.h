// To use with a BlinkMuino, uncomment the following line
#define __BLINKMUINO__

#if defined(__BLINKMUINO__)
// BlinkMuino
const int redPin = 3;   // R, PWM
const int grnPin = 4;   // G, PWM
const int bluPin = 1;   // B, PWM, will blink when programming
const int sdaPin = 0;   // 'd' pin, can be digital I/O
const int sclPin = 2;   // 'c' pin, can be digital I/O, or analog input
#else
// Standard Arduino boards
const int redPin = 3;   // R, PWM
const int grnPin = 5;   // G, PWM
const int bluPin = 6;   // B, PWM, will blink when programming
const int sdaPin = 2;   // 'd' pin, can be digital I/O
const int sclPin = 14;  // 'c' pin, can be digital I/O, or analog input
#endif

