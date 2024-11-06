import streamlit as st
import pydeck as pdk
import time
import paho.mqtt.client as paho

# Hide Streamlit menu and footer
hide_menu_style = """
        <style>
        #MainMenu {visibility: hidden;}
        footer {visibility: hidden;}
        header {visibility: hidden;}
        </style>
        """
st.markdown(hide_menu_style, unsafe_allow_html=True)

st.subheader("Daaffodil Bus Tracking System")

# MQTT client setup
try:
    client = paho.Client()
    client.connect('broker.hivemq.com', 1883)
    client.loop_start()
    client.subscribe('gps/53384', qos=1)

except:
    print("\n\n\n\t\tCheck Your Internet Connection\n\n")

# Initial coordinates
latitude = 23.876835
longitude = 90.320223
set_count = 1
speed = 0.0

# Function to handle MQTT messages
def on_message(client, userdata, msg):
    global latitude, longitude, set_count, speed
    if msg.topic == "gps/53384":
        cor = str(msg.payload)[2:-1].split(",")
        latitude = float(cor[0])
        longitude = float(cor[1])
        set_count = int(cor[2])
        speed = float(cor[3])

# Function to generate random data for the bus location
def generate_random_data():
    return [
        {
            "lat": latitude,
            "lon": longitude,
            "icon_data": {
                "url": "https://img.icons8.com/emoji/48/000000/bus-emoji.png",  # Bus icon
                "width": 128,
                "height": 128,
                "anchorY": 128
            },
            "bus_info": f"Bus ID : 53384",
            "set_info": f"Set : {set_count}, Speed : {speed}"
        }
    ]

# Generate the initial map data
map_data = generate_random_data()

# Create the icon layer for the map
icon_layer = pdk.Layer(
    "IconLayer",
    data=map_data,
    get_icon="icon_data",
    get_position="[lon, lat]",
    get_size=18,  # Increased size for the bus icon
    pickable=True,
)

# Initial map view state
view_state = pdk.ViewState(
    latitude=latitude,
    longitude=longitude,
    zoom=15,
    pitch=50,
)

# Tooltip configuration (without latitude and longitude)
tooltip = {
    "html": "<b>{bus_info}</b> <br>{set_info}",  # Only show bus info without latitude and longitude
    "style": {
        "color": "black",
        "backgroundColor": "white",
        "fontSize": "12px",
        "padding": "5px",
        "borderRadius": "5px"
    }
}

# Display map
map = st.pydeck_chart(pdk.Deck(
    map_style="mapbox://styles/mapbox/light-v9",
    layers=[icon_layer],
    initial_view_state=view_state,
    tooltip=tooltip 
))

# Live update of bus location based on MQTT
while True:
    time.sleep(1)
    client.on_message = on_message
    map_data = generate_random_data()

    # Update the map with new data
    icon_layer.data = map_data  

    # Re-render map with updated GPS coordinates
    map.pydeck_chart(pdk.Deck(
        map_style="mapbox://styles/mapbox/light-v9",
        layers=[icon_layer],
        initial_view_state=view_state,
        tooltip=tooltip 
    ))
