#include <WiFi.h>
#include <Arduino.h>
#include <PubSubClient.h>

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
    Serial.println(WiFi.localIP());
}

void setup()
{
    Serial.begin(9600);
    initWiFi();
    setupMQTT();
}

void loop()
{
    mqttClient.loop();
}