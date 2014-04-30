
#include "Arduino.h"
#include "test.h"

void test_blink()
{
    digitalWrite(13, LOW);
    delay(1000);
    digitalWrite(13, HIGH);
    delay(1000);
}
