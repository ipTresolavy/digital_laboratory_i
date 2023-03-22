// Load Wi-Fi library
#include <WiFi.h>

const int output1 = 13;
const int output2 = 12;
const int output3 = 14;
const int output4 = 27;
const int output5 = 26;
const int output6 = 25;
const int outputacertou = 33;
const int outputerrou = 32;
const int outputbuzzer = 16;

int freq = 440;
int channel = 0;
int resolution = 8;


void setup()
{
    Serial.begin(115200);
    // acertou
    pinMode(outputacertou, INPUT);
    // errou
    pinMode(outputerrou, INPUT);
    ledcSetup(channel, freq, resolution);
    ledcAttachPin(outputbuzzer, channel);
}

void loop()
{
    if (digitalRead(outputacertou) == HIGH)
    {
        ledcWrite(channel, 125);
        delay(1000);
        Serial.println("acertou");
    }
    else if (digitalRead(outputerrou) == HIGH)
    {
        ledcWrite(channel, 250);
        delay(1000);
        Serial.println("errou");
    }
    ledcWrite(channel, 0);
}
