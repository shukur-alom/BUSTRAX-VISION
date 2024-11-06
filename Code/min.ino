#include <WiFi.h>
#include <PubSubClient.h>

WiFiClient wifiClient;
PubSubClient mqttClient(wifiClient);

const char *ssid = "IoT";
const char *password = "61179318";
const char *mqttServer = "broker.hivemq.com";
int mqttPort = 1883;

void setupMQTT()
{
    mqttClient.setServer(mqttServer, mqttPort);
}

void initWiFi()
{
    WiFi.mode(WIFI_STA);
    WiFi.begin(ssid, password);
    Serial.print("Connecting to WiFi ..");
    while (WiFi.status() != WL_CONNECTED)
    {
        Serial.print('.');
        delay(1000);
    }
    Serial.println("Connected to WiFi, IP address: ");
    Serial.println(WiFi.localIP());
}

void setup()
{
    Serial.begin(115200);
    initWiFi();
    setupMQTT();
}

void loop()
{
    if (WiFi.status() != WL_CONNECTED)
    {
        unsigned long currentMillis = millis();
        if (currentMillis - previousMillis >= interval)
        {
            previousMillis = currentMillis;
            WiFi.disconnect();
            initWiFi();
        }
    }
}