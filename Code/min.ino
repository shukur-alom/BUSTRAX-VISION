#include <WiFi.h>
#include <Arduino.h>



const char *ssid = "IoT";
const char *password = "61179318";

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
}

void loop()
{

}