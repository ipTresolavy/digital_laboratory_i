// Load Wi-Fi library
#include <WiFi.h>
#include <PubSubClient.h>

// String user = "grupo2-bancadaA3";
// String passwd = "digi#@2A3";
// const char *mqtt_server = "labdigi.wiseful.com.br";

const char *mqtt_broker = "broker.emqx.io";
const char *topic = "letter";
const char *mqtt_username = "emqx";
const char *mqtt_password = "public";
const int mqtt_port = 1883;

const char *ssid = "PERCIO";
const char *password = "PERWL123";

WiFiClient espClient;
PubSubClient client(espClient);

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

// Current time
unsigned long currentTime = millis();
// Previous time
unsigned long previousTime = 0;
// Define timeout time in milliseconds (example: 2000ms = 2s)
const long timeoutTime = 2000;

void callback(char *topic, byte *message, unsigned int length)
{
    Serial.print("Message arrived on topic: ");
    Serial.print(topic);
    Serial.print(". Message: ");
    String messageTemp;

    for (int i = 0; i < length; i++)
    {
        Serial.print((char)message[i]);
        messageTemp += (char)message[i];
    }
    Serial.println();

    if (String(topic) == "letter")
    {
        if (messageTemp == "A")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, LOW);
            digitalWrite(output3, LOW);
            digitalWrite(output4, LOW);
            digitalWrite(output5, LOW);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "B")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, LOW);
            digitalWrite(output3, HIGH);
            digitalWrite(output4, LOW);
            digitalWrite(output5, LOW);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "C")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, HIGH);
            digitalWrite(output3, LOW);
            digitalWrite(output4, LOW);
            digitalWrite(output5, LOW);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "D")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, HIGH);
            digitalWrite(output3, LOW);
            digitalWrite(output4, HIGH);
            digitalWrite(output5, LOW);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "E")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, LOW);
            digitalWrite(output3, LOW);
            digitalWrite(output4, HIGH);
            digitalWrite(output5, LOW);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "F")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, HIGH);
            digitalWrite(output3, HIGH);
            digitalWrite(output4, LOW);
            digitalWrite(output5, LOW);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "G")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, HIGH);
            digitalWrite(output3, HIGH);
            digitalWrite(output4, HIGH);
            digitalWrite(output5, LOW);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "H")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, LOW);
            digitalWrite(output3, HIGH);
            digitalWrite(output4, HIGH);
            digitalWrite(output5, LOW);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "I")
        {
            digitalWrite(output1, LOW);
            digitalWrite(output2, HIGH);
            digitalWrite(output3, LOW);
            digitalWrite(output4, HIGH);
            digitalWrite(output5, LOW);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "J")
        {
            digitalWrite(output1, LOW);
            digitalWrite(output2, HIGH);
            digitalWrite(output3, HIGH);
            digitalWrite(output4, HIGH);
            digitalWrite(output5, HIGH);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "K")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, LOW);
            digitalWrite(output3, LOW);
            digitalWrite(output4, LOW);
            digitalWrite(output5, HIGH);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "L")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, LOW);
            digitalWrite(output3, HIGH);
            digitalWrite(output4, LOW);
            digitalWrite(output5, HIGH);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "M")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, HIGH);
            digitalWrite(output3, LOW);
            digitalWrite(output4, LOW);
            digitalWrite(output5, HIGH);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "N")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, HIGH);
            digitalWrite(output3, LOW);
            digitalWrite(output4, HIGH);
            digitalWrite(output5, HIGH);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "O")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, LOW);
            digitalWrite(output3, LOW);
            digitalWrite(output4, HIGH);
            digitalWrite(output5, LOW);
            digitalWrite(output6, HIGH);
        }
        else if (messageTemp == "P")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, HIGH);
            digitalWrite(output3, HIGH);
            digitalWrite(output4, LOW);
            digitalWrite(output5, HIGH);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "Q")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, HIGH);
            digitalWrite(output3, HIGH);
            digitalWrite(output4, HIGH);
            digitalWrite(output5, HIGH);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "R")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, LOW);
            digitalWrite(output3, HIGH);
            digitalWrite(output4, HIGH);
            digitalWrite(output5, HIGH);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "S")
        {
            digitalWrite(output1, LOW);
            digitalWrite(output2, HIGH);
            digitalWrite(output3, HIGH);
            digitalWrite(output4, LOW);
            digitalWrite(output5, HIGH);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "T")
        {
            digitalWrite(output1, LOW);
            digitalWrite(output2, HIGH);
            digitalWrite(output3, HIGH);
            digitalWrite(output4, HIGH);
            digitalWrite(output5, HIGH);
            digitalWrite(output6, LOW);
        }
        else if (messageTemp == "U")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, LOW);
            digitalWrite(output3, LOW);
            digitalWrite(output4, LOW);
            digitalWrite(output5, HIGH);
            digitalWrite(output6, HIGH);
        }
        else if (messageTemp == "V")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, LOW);
            digitalWrite(output3, HIGH);
            digitalWrite(output4, LOW);
            digitalWrite(output5, HIGH);
            digitalWrite(output6, HIGH);
        }
        else if (messageTemp == "W")
        {
            digitalWrite(output1, LOW);
            digitalWrite(output2, HIGH);
            digitalWrite(output3, HIGH);
            digitalWrite(output4, HIGH);
            digitalWrite(output5, LOW);
            digitalWrite(output6, HIGH);
        }
        else if (messageTemp == "X")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, HIGH);
            digitalWrite(output3, LOW);
            digitalWrite(output4, LOW);
            digitalWrite(output5, HIGH);
            digitalWrite(output6, HIGH);
        }
        else if (messageTemp == "Y")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, HIGH);
            digitalWrite(output3, LOW);
            digitalWrite(output4, HIGH);
            digitalWrite(output5, HIGH);
            digitalWrite(output6, HIGH);
        }
        else if (messageTemp == "Z")
        {
            digitalWrite(output1, HIGH);
            digitalWrite(output2, LOW);
            digitalWrite(output3, LOW);
            digitalWrite(output4, HIGH);
            digitalWrite(output5, HIGH);
            digitalWrite(output6, HIGH);
        }
    }
}

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
    pinMode(outputacertou, INPUT);
    // errou
    pinMode(outputerrou, INPUT);
    // buzzer
    ledcSetup(channel, freq, resolution);
    ledcAttachPin(outputbuzzer, channel);

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
    connect_mqtt();
}

void reconnect()
{
    while (!client.connected())
    {
        Serial.print("Attempting MQTT connection...");
        // Attempt to connect
        if (client.connect("Web server"))
        {
            Serial.println("connected");
            // Subscribe
            client.subscribe("letter");
        }
        else
        {
            Serial.print("failed, rc=");
            Serial.print(client.state());
            Serial.println(" try again in 5 seconds");
            // Wait 3 seconds before retrying
            delay(3000);
        }
    }
}
void connect_mqtt()
{
    client.setServer(mqtt_broker, mqtt_port);
    client.setCallback(callback);
    while (!client.connected())
    {
        String client_id = "esp32-client-";
        client_id += String(WiFi.macAddress());
        Serial.printf("The client %s connects to the public mqtt broker\n", client_id.c_str());
        if (client.connect(client_id.c_str(), mqtt_username, mqtt_password))
        {
            Serial.println("Public emqx mqtt broker connected");
            ;
        }
        else
        {
            Serial.print("failed with state ");
            Serial.print(client.state());
            delay(2000);
        }
    }
    // publish and subscribe
    client.publish(topic, "Hi EMQX I'm ESP32 ^^");
    client.subscribe(topic);
}

void loop()
{
    client.loop();
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
    // If a new client connects,
    // loop while the client's connected
    //
    //  1  2
    //  3  4
    //  5  6
    //
    // sets the GPIO signal to the ascii value received:
}
