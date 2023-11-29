/*
  Code for our Automatic Smart Watering system, Plant Doctor,
  that detects soil moisture and waters the soil as needed based
  on moisture level. Additionally, the code detects the sunlight
  levels of the room and whether the room light is bright enough for 
  the plant. 

  CS 6452 - Prototyping Interactive Systems
*/
// Declare variables for pins
const int sensorPin = A0;
const int sensorPower = 8;
const int photoresistorPin = A1;

// Variable for sensor readings
int sensorValue;
int lightValue;

// Delay time between sensor readings (milliseconds)
const int longDelayTime = 1000;
const int shortDelayTime = 10;

// The wet and dry thresholds for the soil
// Wetness level is between the range 200 to 240
// Dryness level is between the range 480 to 540
int wetLow = 200;
int wetHigh = 240; 
int dryLow = 480;
int dryHigh = 540;

// The sunlight threshold for brightness
int lightThreshold = 200;

void setup(){ // code that only runs once
  // Set pins as outputs
  pinMode(sensorPower,OUTPUT);
 
  // Initialize serial communication
  Serial.begin(9600);
}


void loop(){ // code that loops forever
  
  
  // Take reading from sensors
  sensorValue = analogRead(sensorPin);

  // Print the light and moisture sensor readings to the serial monitor
  Serial.println(sensorValue);       
 
  if (Serial.available() > 0) {
    char pumpState = Serial.read();
    if (pumpState == '1') {
      digitalWrite(sensorPower,HIGH); 
    } 
    else if (pumpState == '0') {
      digitalWrite(sensorPower,LOW);
    }
  }

}
