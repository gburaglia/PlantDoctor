import processing.serial.*;

Serial serial;  // Create object from Serial class
String val;     // Data received from the serial port
String [] valArray; // Array of arduino values
PImage welcomeScreen;
PImage plantScreen;
int systemState; // 0-2 depending on screen and action
ArrayList<Rain> rainArray; // Array collection of rain objects
Plant firstPlant; // Plant object
int timer;
int duration;
int timePassed;
int timeLeft;
String portName;

// Initializes and sets items to their orignial values
void setup(){
   size(1280,800);
   welcomeScreen = loadImage("welcomeScreen.png");
   image(welcomeScreen, 0, 0);
   rainArray = new ArrayList<Rain>(); // Initializes rain array
   systemState = 0; // Initial system state
   portName = Serial.list()[2]; // Set to 2 to get correct port
   serial = new Serial(this, portName, 9600);
   firstPlant =  new Plant(0.0, 0.0, 480); // Initializes rain array
   timer = millis();
   timePassed = millis();
   timeLeft = duration = 3;
   createRain();
}

// Loop that keeps running while program is executed
void draw(){
  if (serial.available() > 0){  // If data is available
    readSerialValue();
  }
  
  // As long as value isn't 0, shows next screen
  if(systemState != 0)
  {
    showPlantScreen("plantScreen.png");
  }
  
  if(systemState == 1)
  {
    if(timer % 15==0)
    {
      serial.write('0'); // Writes 0 to Arduino to keep pump off
    }
    timePassed = millis();
  }
  else if (systemState==2) // System state changes 2 when water button is pressed
  {
    if (timeLeft > 0) {
      serial.write('1'); // Writes 1 to Arduino to turn pump on
      timeLeft = duration - ((millis() - timePassed)/1000);
       for (Rain rainPart : rainArray)
      {
         rainPart.draw(); // Draws rain animation
      }  
    }
    else {
      if(timeLeft ==0)
      {
         serial.write('0'); // Writes 0 to Arduino to keep pump off
      }
      timeLeft = duration;
      systemState = 1;
      timePassed = millis();
      resetRain();
    }
  }
  else{
       timePassed = millis();
    }
}

// Creates 10 rain object each with 30 rain drops
void createRain()
{
  for(int i=0; i<10;i++)
  {
    //each rain object is added to rainArray
    rainArray.add(new Rain(30));
  }
}

// Resets rain array and recreates it
void resetRain()
{
  //clear rainArray to start over
  rainArray.clear();
  createRain();
}

// Triggered by button on start screen and second screen
void mouseClicked()
{
  // On first screen to start the check up experience
  if (systemState == 0 & mouseX > 95 & mouseX < 400 & mouseY > 575 & mouseY < 650)
  {
    showPlantScreen("plantScreen.png");
    systemState = 1;
  } 
  // On second screen to water the plant
  else if (systemState != 0 & mouseX > 175 & mouseX < 575 & mouseY > 25 & mouseY < 150)
  {
    systemState = 2;
  } 
     
}

// Showing plant screen
void showPlantScreen(String backgroundFile){
  background(255);
  plantScreen = loadImage(backgroundFile);
  image(plantScreen, 0, 0);
  screenText();
  
}

// Text for plant screen
void screenText()
{
  fill(0);
  
  // Printing sensor values to screen
  textSize(48);
  text(int(firstPlant.plantHum),width-175,160);
  text(int(firstPlant.plantLight),width-175,500);
  
  // Printing sensor status to screen
  textSize(32);
  text(firstPlant.assessWaterLevel(),width-460,200);
  text(firstPlant.assessLightLevel(),width-390,540);  
}

void readSerialValue(){
   // Read values from Arduino it and store it in val
    val = serial.readStringUntil('\n');
     if(val != null){
       if(match(val, ":")!= null)
      {
        valArray = split(val, " ");
        // If matches all conditions update it as Light and Hum values
         if(valArray.length > 6){
           firstPlant.updateLight(float(valArray[2]));
           firstPlant.updateHum(float(valArray[6]));
        }
      }
    } 
}
