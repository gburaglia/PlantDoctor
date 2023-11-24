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
int lightThreshold = 700;

void setup(){ // code that only runs once
  // Set pins as outputs
  pinMode(sensorPower,OUTPUT);
 
  // Initialize serial communication
  Serial.begin(9600);
}

// TODO: Determine which delay time we prefer (short or long)
void loop(){ // code that loops forever
  
  delay(shortDelayTime);

  // Take reading from sensors
  sensorValue = analogRead(sensorPin);
  lightValue = analogRead(photoresistorPin);

  // Print the light and moisture sensor readings to the serial monitor
  Serial.print("Photoresistor value:");
  Serial.print(lightValue);    
  Serial.print("  Soil moisture value:");
  Serial.println(sensorValue);       
 
  // If the sensor reading is between the wet range values, turn off the motor pump
  if(sensorValue > wetLow && sensorValue < wetHigh){ // the soil is wet
    digitalWrite(sensorPower,LOW);
  }
  // If the sensor reading is between the dry range values, power on the motor pump to water the soil
  else if(sensorValue > dryLow && sensorValue < dryHigh ){ // the soil is dry

    digitalWrite(sensorPower,HIGH);
  }

  // If the light value readings is below the threshold, the room is too dark. Otherwise, the sunlight is adequate
   if (lightValue < lightThreshold) {
    Serial.println("The room is too dark for your plant");
   } else {
    Serial.println("The room has sunlight that is just right for your plant.");
   }
 
  // Wait before taking next reading
  delay(longDelayTime);
 
}
