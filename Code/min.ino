#include <WiFi.h>

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
}

void loop()
{
}
