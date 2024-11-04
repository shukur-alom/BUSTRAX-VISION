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

void reconnectMQTT()
{
    while (!mqttClient.connected())
    {
        Serial.print("Attempting MQTT connection...");
        String clientId = "ESP32Client-";
        clientId += String(random(0xffff), HEX);
        if (mqttClient.connect(clientId.c_str()))
        {
            Serial.println("Connected to MQTT broker.");
        }
        else
        {
            Serial.print("failed, rc=");
            Serial.print(mqttClient.state());
            Serial.println(" try again in 5 seconds");
            delay(5000);
        }
    }
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
    Serial.begin(9600);
    initWiFi();
    setupMQTT();
}

void loop()
{
    Serial.begin(115200);
    gpsSerial.begin(GPS_BAUD, SERIAL_8N1, RXD2, TXD2);
    Serial.println("Serial 2 started at 9600 baud rate");

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

    if (!mqttClient.connected())
    {
        reconnectMQTT();
    }

    mqttClient.loop();
}