#include <TinyGPS++.h>
#include <WiFi.h>
#include <Arduino.h>
#include <PubSubClient.h>

// Define the RX and TX pins for Serial 2
#define RXD2 16
#define TXD2 17
#define GPS_BAUD 9600

// The TinyGPS++ object
TinyGPSPlus gps;

// Create an instance of the HardwareSerial class for Serial 2
HardwareSerial gpsSerial(2);

float latitude = 23.876835;
float longitude = 90.320223;
int count_se = 1;
float v_speed = 0.0;

unsigned long previousMillis = 0;
unsigned long interval = 30000; // 30 seconds for WiFi reconnection

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

    // Process GPS data
    while (gpsSerial.available() > 0)
    {
        gps.encode(gpsSerial.read());
    }

    if (gps.location.isUpdated())
    {
        latitude = gps.location.lat();
        longitude = gps.location.lng();
        count_se = gps.satellites.value();
        v_speed = gps.speed.kmph();

        Serial.print("LAT: ");
        Serial.println(latitude, 6);
        Serial.print("LONG: ");
        Serial.println(longitude, 6);
        Serial.print("Satellites = ");
        Serial.println(count_se);

        if (v_speed <= 5.0)
        {
            v_speed = 0.0;
        }

        Serial.print("SPEED (km/h) = ");
        Serial.println(v_speed);
        Serial.println("");
    }

    String payload = String(latitude, 7) + "," + String(longitude, 7) + "," + String(count_se) + "," + String(v_speed);
    mqttClient.publish("gps/53384", payload.c_str());

    delay(1000);
}
