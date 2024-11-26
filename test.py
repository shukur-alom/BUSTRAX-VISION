import paho.mqtt.client as paho
import time

# MQTT client setup
try:
    client = paho.Client()
    client.connect('broker.emqx.io', 1883)
    client.loop_start()
    client.subscribe('gps/53384', qos=1)


except:
    print("\n\n\n\t\tCheck Your Internet Connection\n\n")

latitude = 23.876835
longitude = 90.320223
set_count = 1
speed = 0.0

# Function to handle MQTT messages
def on_message(client, userdata, msg):
    global latitude, longitude, set_count, speed
    # if msg.topic == "gps/53384":
    #print(str(msg.payload))

while True:
    time.sleep(2)
    client.on_message = on_message
    
    payload = input("Enter the payload: ")
    client.publish('gps/61179', payload, qos=1)
    print("Published")

