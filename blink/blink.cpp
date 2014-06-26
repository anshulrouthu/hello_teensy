
#include "Arduino.h"
#include "test.h"

#define LED_PIN 13

void setup()
{
    pinMode(LED_PIN, OUTPUT);
}

void loop()
{
	test_blink();
}
