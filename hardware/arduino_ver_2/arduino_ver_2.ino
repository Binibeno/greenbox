/*
	Esp32 Websockets Client

	This sketch:
        1. Connects to a WiFi network
        2. Connects to a Websockets server
        3. Sends the websockets server a message ("Hello Server")
        4. Prints all incoming messages while the connection is open

	Hardware:
        For this sketch you only need an ESP32 board.

	Created 15/02/2019
	By Gil Maimon
	https://github.com/gilmaimon/ArduinoWebsockets

*/

#include <ArduinoWebsockets.h>
#include <WiFi.h>
#include <Adafruit_GFX.h>     // Core graphics library
#include <Adafruit_ST7789.h>  // Hardware-specific library for ST7789
#include <Fonts/FreeSans12pt7b.h>

#include <WString.h>


// Use dedicated hardware SPI pins
Adafruit_ST7789 display = Adafruit_ST7789(TFT_CS, TFT_DC, TFT_RST);

const int maxwidth = 240;
const int maxheight = 130;

GFXcanvas16 canvas(240, 135);


const char* ssid = "UPC37DD4B3";               //Enter SSID
const char* password = "swe6PfzahW6a";         //Enter Password
const uint16_t websockets_server_port = 8080;  // Enter server port

using namespace websockets;

WebsocketsClient client;
void setup() {
  Serial.begin(115200);

  // turn on backlite
  pinMode(TFT_BACKLITE, OUTPUT);
  digitalWrite(TFT_BACKLITE, HIGH);

  // turn on the TFT / I2C power supply
  pinMode(TFT_I2C_POWER, OUTPUT);
  digitalWrite(TFT_I2C_POWER, HIGH);
  delay(10);


  // initialize TFT
  display.init(135, 240);  // Init ST7789 240x135
  display.setRotation(1);

  canvas.setFont(&FreeSans12pt7b);
  canvas.setTextColor(ST77XX_WHITE);

  Serial.println(F("Initialized TFT"));
  canvas.fillScreen(ST77XX_BLACK);
  display.drawRGBBitmap(0, 0, canvas.getBuffer(), 240, 135);
  canvas.setTextColor(ST77XX_GREEN);


  // Connect to wifi
  WiFi.begin(ssid, password);

  // Wait some time to connect to wifi
  for (int i = 0; i < 10 && WiFi.status() != WL_CONNECTED; i++) {
    Serial.print(".");
    delay(1000);
  }

  // Check if connected to wifi
  if (WiFi.status() != WL_CONNECTED) {
    Serial.println("No Wifi!");
    return;
  }

  Serial.println("Connected to Wifi, Connecting to server.");


  // Get the bounding box of the text
  int16_t x, y;
  uint16_t width, height;
  canvas.getTextBounds("WIFI CONNECTED", 0, 0, &x, &y, &width, &height);

  canvas.setCursor((maxwidth / 2) - (width / 2), 60);
  canvas.println("WIFI CONNECTED");
  display.drawRGBBitmap(0, 0, canvas.getBuffer(), 240, 135);

  const char* websockets_server_host = "192.168.0.66";  //Enter server adress

  // try to connect to Websockets server
  bool connected = client.connect(websockets_server_host, websockets_server_port, "/");
  pinMode(A1, INPUT);
  if (connected) {
    Serial.println("Connected!");
    // Get the bounding box of the text
    int16_t x, y;
    uint16_t width, height;
    canvas.getTextBounds("SERVER OK", 0, 0, &x, &y, &width, &height);

    canvas.setCursor((maxwidth / 2) - (width / 2), 90);
    canvas.println("SERVER OK");
    display.drawRGBBitmap(0, 0, canvas.getBuffer(), 240, 135);
    // client.send("Hello Server");
  } else {
    Serial.println("Not Connected!");
  }

  // run callback when messages are received
  client.onMessage([&](WebsocketsMessage message) {
    Serial.print("Got Message: ");
    Serial.println(message.data());
  });
}

void loop() {
  // let the websockets client check for incoming messages
  if (client.available()) {
    client.poll();
  }


  delay(15);

  int sum = 0;
  for (int i = 0; i < 6; i++) {
    sum += analogRead(A1);
  }
  int a = sum / 6;

  String myString = String(a);
  client.send(myString);
  Serial.println(myString);
}
