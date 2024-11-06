import streamlit as st
import pydeck as pdk
import time
import random
import paho.mqtt.client as paho


try:
    client = paho.Client()
    client.connect('broker.hivemq.com', 1883)
    client.loop_start()
    client.subscribe('gps/53384', qos=1)

except: print("\n\n\n\t\tCheck Your Internet Connection\n\n")

latitude = 23.876835
longitude = 90.320223
set_count = 1
speed = 0.0

def on_message(client, userdata, msg):
    global latitude
    global longitude
    global set_count
    if msg.topic == "gps/53384":
        cor = str(msg.payload)[2:-1].split(",")
        latitude = float(cor[0])
        longitude = float(cor[1])
        set_count = int(cor[2])
        speed = float(cor[3])


def generate_random_data():
    return [
        {
            "lat": latitude,
            "lon": longitude,
            "icon_data": {
                "url": "https://img.icons8.com/emoji/48/000000/bus-emoji.png",  # URL of the bus icon
                "width": 128,
                "height": 128,
                "anchorY": 128
            },
            "info": f"""Bus ID : 53384\nSet : {set_count}\n
            Speed : {speed}"""  # Custom information for each bus
        }
    ]

st.title("Live Location Map with Bus Icon and Tooltip")

map_data = generate_random_data()

icon_layer = pdk.Layer(
    "IconLayer",
    data=map_data,
    get_icon="icon_data",
    get_position="[lon, lat]",
    get_size=18,  # Increased size for the bus icon
    pickable=True,
)


view_state = pdk.ViewState(
    latitude=latitude,
    longitude=longitude,
    zoom=15,
    pitch=50,
)

tooltip = {
    "html": "<b>{info}</b><br>Latitude: {lat}<br>Longitude: {lon}",
    "style": {
        "color": "white",
        "backgroundColor": "black",
        "fontSize": "12px",
        "padding": "5px",
        "borderRadius": "5px"
    }
}


map = st.pydeck_chart(pdk.Deck(
    map_style="mapbox://styles/mapbox/light-v9",
    layers=[icon_layer],
    initial_view_state=view_state,
    tooltip=tooltip 
))


st.write("Tracking Bus Location in Real-Time:")
while True:
    time.sleep(1)
    client.on_message = on_message
    map_data = generate_random_data()

    icon_layer.data = map_data  
    
    map.pydeck_chart(pdk.Deck(
        map_style="mapbox://styles/mapbox/light-v9",
        layers=[icon_layer],
        initial_view_state=view_state,
        tooltip=tooltip 
    ))
