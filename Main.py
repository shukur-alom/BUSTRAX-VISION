import streamlit as st
import pydeck as pdk
import time
import random


def generate_random_data():
    return [
        {
            "lat": 37.7749 + random.uniform(-0.01, 0.01),
            "lon": -122.4194 + random.uniform(-0.01, 0.01),
            "icon_data": {
                "url": "https://img.icons8.com/emoji/48/000000/bus-emoji.png",  # URL of the bus icon
                "width": 128,
                "height": 128,
                "anchorY": 128
            },
            "info": f"Bus at ({round(37.7749 + random.uniform(-0.01, 0.01), 4)}, {round(-122.4194 + random.uniform(-0.01, 0.01), 4)})"  # Custom information for each bus
        }
    ]

st.title("Live Location Map with Bus Icon and Tooltip")

map_data = generate_random_data()

icon_layer = pdk.Layer(
    "IconLayer",
    data=map_data,
    get_icon="icon_data",
    get_position="[lon, lat]",
    get_size=25,  # Increased size for the bus icon
    pickable=True,
)


view_state = pdk.ViewState(
    latitude=37.7749,
    longitude=-122.4194,
    zoom=12,
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
    time.sleep(5)
    map_data = generate_random_data()
    icon_layer.data = map_data  
    map.pydeck_chart(pdk.Deck(
        map_style="mapbox://styles/mapbox/light-v9",
        layers=[icon_layer],
        initial_view_state=view_state,
        tooltip=tooltip 
    ))
