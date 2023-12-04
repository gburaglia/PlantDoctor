/*
  Code for hardware of Plant Doctor,
  system that detects soil moisture and let's user water the soil as needed based
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
int timer;

// The sunlight threshold for brightness
int lightThreshold = 500;

char pumpState;

void setup(){ // code that only runs once
  // Set pins as outputs
  pinMode(sensorPower,OUTPUT);
 
  // Initialize serial communication
  Serial.begin(9600);
  timer = millis();
}

void loop(){ // code that loops forever
  
  // Take reading from sensors
  sensorValue = analogRead(sensorPin);
  lightValue = analogRead(photoresistorPin);

  if(timer % 333==0) //To make readings less frequent and not overwhelm the serial monitor
  {
    // Print the light and moisture sensor readings to the serial monitor
    Serial.print("Photoresistor value: ");
    Serial.print(lightValue);    
    Serial.print(" Soil moisture value: ");
    Serial.println(sensorValue);   
  }
      
 
 // Runs pump only if it receives a 1 from Processing code
 // The 1 is received when the "Water" button is pressed by user
   if (Serial.available() > 0) {
    pumpState = Serial.read();
    if (pumpState == '1') {
      digitalWrite(sensorPower,HIGH); 
    } 
    else if (pumpState == '0') {
      digitalWrite(sensorPower,LOW);
    }
    else {
      digitalWrite(sensorPower,LOW);
    }
  }
   //To make readings less frequent and not overwhelm the serial monitor
   if (lightValue < lightThreshold && timer % 333==0) {
    Serial.println("The room is too dark for your plant");
   } else {
    Serial.println("The room has sunlight that is just right for your plant.");
   }
   
}
