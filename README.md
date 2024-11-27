# BUSTRAX VISION 

## Overview

BUSTRAX VISION is an innovative, all-encompassing solution that tack the complexities of modern transportation management. By integrating IoT devices with a robust web application and a user-friendly mobile app, BUSTRAX VISION offers an intelligent system for tracking, managing, and optimizing transportation networks.

At its core, BUSTRAX VISION utilizes advanced IoT technology to gather real-time data from vehicles. These IoT devices, embedded within the transport system, continuously monitor and transmit critical parameters such as location, speed, and vehicle status. This real-time data ensures efficient operations, proactive decision-making, and enhanced safety.

## Key Features

### IoT-Powered Vehicle Monitoring

BUSTRAX VISION leverages IoT devices to provide live updates on vehicle movements, operational parameters, and potential anomalies. These insights allow administrators to make data-driven decisions that improve fleet efficiency and minimize risks.

### User-Friendly Mobile App

Designed for convenience, the mobile app serves Admin and passengers:

- **For Passengers**: View real-time vehicle locations, estimated arrival times, and route updates, ensuring a seamless travel experience.
- **For Admin**: Monitor vehicle movements on an interactive map, define operational boundaries for vehicles with alerts for zone breaches, and remotely stop vehicles in case of unauthorized use or theft, ensuring enhanced security.

### Advanced Web Application for Administrators

The solution includes a feature-rich web platform designed for administrative control:

- **Live Tracking**: Monitor vehicle movements on an interactive map.
- **Geo-Fencing**: Define operational boundaries for vehicles, triggering alerts when they move outside designated zones.
- **Remote Vehicle Control**: In case of unauthorized use or theft, administrators can remotely stop the vehicle, ensuring enhanced security.


## IoT Code Upload

The IoT devices are programmed to collect and transmit data related to the transportation system. The code for these devices is uploaded to the microcontrollers, which then communicate with the central server to provide real-time tracking and monitoring.

![IoT Device](https://github.com/shukur-alom/DIU-Transport-Track/blob/master/IOT%20Device/Circuit%20Diagram/main.png)


### How to Upload IoT Device Code

To upload the code to the IoT devices, follow these steps:

1. **Connect the Device**: Use a USB cable to connect the IoT device to your computer.
2. **Open Programming Environment**: Launch the Arduino IDE or your preferred microcontroller programming environment.
3. **Load the Code**: Navigate to the `/IOT Device/Code/min.ino` directory and load the IoT device code.
4. **Select Board and Port**: From the Tools menu, select the appropriate board and port.
5. **Upload the Code**: Click the upload button to flash the code onto the IoT device.
6. **Verify Operation**: Once the upload is complete, the device will begin collecting and transmitting data.


## Mobile App

The mobile app offers similar functionalities to the web application but is optimized for mobile devices. It allows users to track vehicles, receive notifications, and access transportation information on the go. The app ensures that users have access to the transportation system anytime, anywhere.

![Mobile App](https://github.com/shukur-alom/BUSTRAX-VISION/blob/master/Media/CODE%208_page-0007.jpg)

### How to Run the Mobile App

To run the mobile app, follow these steps:

1. **Clone the Repository**: Clone the repository to your local machine:
    ```bash
    git clone https://github.com/shukur-alom/BUSTRAX-VISION.git
    ```
2. **Navigate to Directory**: Change to the mobile app directory:
    ```bash
    cd BUSTRAX-VISION/Mobile App
    ```
3. **Install Dependencies**: Install the required dependencies:
    ```bash
    npm install
    ```
4. **Run the App**: Run the app on an emulator or physical device:
    ```bash
    npm run android   # For Android
    npm run ios       # For iOS
    ```


## Web Application

The web application provides an interface for users to monitor the transportation system. It displays real-time bus locations, allowing users to track the current position of buses and plan their journeys accordingly.

![Web Application](https://github.com/shukur-alom/BUSTRAX-VISION/blob/master/Media/CODE%208_page-0008.jpg)

### How to Set Up and Run the Web Application

To set up and run the web application, follow these steps:

1. **Clone the Repository**: Clone the repository to your local machine:
    ```bash
    git clone https://github.com/shukur-alom/BUSTRAX-VISION.git
    ```
2. **Navigate to Directory**: Change to the web application directory:
    ```bash
    cd BUSTRAX-VISION/webapp
    ```
3. **Install Dependencies**: Install the required dependencies:
    ```bash
    pip install -r requirements.txt
    ```
4. **Start the Server**: Start the Streamlit server:
    ```bash
    streamlit run app.py
    ```

## Conclusion

BUSTRAX VISION leverages IoT technology, a web application, and a mobile app to provide a robust solution for transportation management. This integrated system enhances efficiency, safety, and convenience for all users.


## Contributors

The following individuals have contributed to the development of BUSTRAX VISION:

- **Shukur Alam** - [LinkedIn](https://www.linkedin.com/in/shukur-alam/)
- **Ahmad Bin Mijanur Rahman** - [LinkedIn](https://www.linkedin.com/in/ahmad-bin-mijanur-rahman-swe/)
- **Alok Saha** - [LinkedIn](https://www.linkedin.com/in/alok-saha-811968238/)