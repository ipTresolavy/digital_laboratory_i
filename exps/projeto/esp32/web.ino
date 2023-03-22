// Load Wi-Fi library
#include <WiFi.h>

String user = "login_MQTT";
String passwd = "senha_MQTT";

// Replace with your network credentials
const char *ssid = "PERCIO";
const char *password = "PERWL123";
const char *mqtt_server = "endereco_broker";

WiFiClient espClient;
PubSubClient client(espClient);

// Auxiliar variables to store the current output state
String output26State = "off";
String output27State = "off";

// Assign output variables to GPIO pins of the ESP32
const int output1 = 13;
const int output2 = 12;
const int output3 = 14;
const int output4 = 27;
const int output5 = 26;
const int output6 = 25;
const int output7 = 33;
const int output8 = 32;
const int outputbuzzer = 16;

int freq = 440;
int channel = 0;
int resolution = 8;

// Current time
unsigned long currentTime = millis();
// Previous time
unsigned long previousTime = 0;
// Define timeout time in milliseconds (example: 2000ms = 2s)
const long timeoutTime = 2000;

void setup()
{
    Serial.begin(115200);
    // Initialize the output variables as outputs
    pinMode(output1, OUTPUT);
    pinMode(output2, OUTPUT);
    pinMode(output3, OUTPUT);
    pinMode(output4, OUTPUT);
    pinMode(output5, OUTPUT);
    pinMode(output6, OUTPUT);
    // acertou
    pinMode(output7, INPUT);
    // errou
    pinMode(output8, INPUT);
    // buzzer
    // Set outputs to LOW
    digitalWrite(output1, LOW);
    digitalWrite(output2, LOW);
    digitalWrite(output3, LOW);
    digitalWrite(output4, LOW);
    digitalWrite(output5, LOW);
    digitalWrite(output6, LOW);

    // Connect to Wi-Fi network with SSID and password
    Serial.print("Connecting to ");
    Serial.println(ssid);
    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED)
    {
        delay(500);
        Serial.print(".");
    }
    // Print local IP address and start web server
    Serial.println("");
    Serial.println("WiFi connected.");
    Serial.println("IP address: ");
    Serial.println(WiFi.localIP());
    client.setServer(mqtt_server, 80);

    ledcSetup(channel, freq, resolution);
    ledcAttachPin(outputbuzzer, channel);
}

void loop()
{
    if (digitalRead(output7) == HIGH)
    {
        ledcWrite(channel, 125);
        delay(1000);
        Serial.println("acertou");
    }
    else if (digitalRead(output8) == HIGH)
    {
        ledcWrite(channel, 250);
        delay(1000);
        Serial.println("errou");
    }
    ledcWrite(channel, 0);

    if (client)
    {     // If a new client connects,
        { // loop while the client's connected
            //
            //  1  2
            //  3  4
            //  5  6
            //

            // sets the GPIO signal to the ascii value received:
            if (header.indexOf("GET /A") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, LOW);
                digitalWrite(output3, LOW);
                digitalWrite(output4, LOW);
                digitalWrite(output5, LOW);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /B") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, LOW);
                digitalWrite(output3, HIGH);
                digitalWrite(output4, LOW);
                digitalWrite(output5, LOW);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /C") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, HIGH);
                digitalWrite(output3, LOW);
                digitalWrite(output4, LOW);
                digitalWrite(output5, LOW);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /D") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, HIGH);
                digitalWrite(output3, LOW);
                digitalWrite(output4, HIGH);
                digitalWrite(output5, LOW);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /E") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, LOW);
                digitalWrite(output3, LOW);
                digitalWrite(output4, HIGH);
                digitalWrite(output5, LOW);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /F") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, HIGH);
                digitalWrite(output3, HIGH);
                digitalWrite(output4, LOW);
                digitalWrite(output5, LOW);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /G") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, HIGH);
                digitalWrite(output3, HIGH);
                digitalWrite(output4, HIGH);
                digitalWrite(output5, LOW);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /H") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, LOW);
                digitalWrite(output3, HIGH);
                digitalWrite(output4, HIGH);
                digitalWrite(output5, LOW);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /I") >= 0)
            {
                digitalWrite(output1, LOW);
                digitalWrite(output2, HIGH);
                digitalWrite(output3, LOW);
                digitalWrite(output4, HIGH);
                digitalWrite(output5, LOW);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /J") >= 0)
            {
                digitalWrite(output1, LOW);
                digitalWrite(output2, HIGH);
                digitalWrite(output3, HIGH);
                digitalWrite(output4, HIGH);
                digitalWrite(output5, HIGH);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /K") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, LOW);
                digitalWrite(output3, LOW);
                digitalWrite(output4, LOW);
                digitalWrite(output5, HIGH);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /L") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, LOW);
                digitalWrite(output3, HIGH);
                digitalWrite(output4, LOW);
                digitalWrite(output5, HIGH);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /M") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, HIGH);
                digitalWrite(output3, LOW);
                digitalWrite(output4, LOW);
                digitalWrite(output5, HIGH);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /N") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, HIGH);
                digitalWrite(output3, LOW);
                digitalWrite(output4, HIGH);
                digitalWrite(output5, HIGH);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /O") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, LOW);
                digitalWrite(output3, LOW);
                digitalWrite(output4, HIGH);
                digitalWrite(output5, LOW);
                digitalWrite(output6, HIGH);
            }
            else if (header.indexOf("GET /P") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, HIGH);
                digitalWrite(output3, HIGH);
                digitalWrite(output4, LOW);
                digitalWrite(output5, HIGH);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /Q") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, HIGH);
                digitalWrite(output3, HIGH);
                digitalWrite(output4, HIGH);
                digitalWrite(output5, HIGH);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /R") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, LOW);
                digitalWrite(output3, HIGH);
                digitalWrite(output4, HIGH);
                digitalWrite(output5, HIGH);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /S") >= 0)
            {
                digitalWrite(output1, LOW);
                digitalWrite(output2, HIGH);
                digitalWrite(output3, HIGH);
                digitalWrite(output4, LOW);
                digitalWrite(output5, HIGH);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /T") >= 0)
            {
                digitalWrite(output1, LOW);
                digitalWrite(output2, HIGH);
                digitalWrite(output3, HIGH);
                digitalWrite(output4, HIGH);
                digitalWrite(output5, HIGH);
                digitalWrite(output6, LOW);
            }
            else if (header.indexOf("GET /U") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, LOW);
                digitalWrite(output3, LOW);
                digitalWrite(output4, LOW);
                digitalWrite(output5, HIGH);
                digitalWrite(output6, HIGH);
            }
            else if (header.indexOf("GET /V") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, LOW);
                digitalWrite(output3, HIGH);
                digitalWrite(output4, LOW);
                digitalWrite(output5, HIGH);
                digitalWrite(output6, HIGH);
            }
            else if (header.indexOf("GET /W") >= 0)
            {
                digitalWrite(output1, LOW);
                digitalWrite(output2, HIGH);
                digitalWrite(output3, HIGH);
                digitalWrite(output4, HIGH);
                digitalWrite(output5, LOW);
                digitalWrite(output6, HIGH);
            }
            else if (header.indexOf("GET /X") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, HIGH);
                digitalWrite(output3, LOW);
                digitalWrite(output4, LOW);
                digitalWrite(output5, HIGH);
                digitalWrite(output6, HIGH);
            }
            else if (header.indexOf("GET /Y") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, HIGH);
                digitalWrite(output3, LOW);
                digitalWrite(output4, HIGH);
                digitalWrite(output5, HIGH);
                digitalWrite(output6, HIGH);
            }
            else if (header.indexOf("GET /Z") >= 0)
            {
                digitalWrite(output1, HIGH);
                digitalWrite(output2, LOW);
                digitalWrite(output3, LOW);
                digitalWrite(output4, LOW);
                digitalWrite(output5, LOW);
                digitalWrite(output6, LOW);
            }
        }
    }
}
