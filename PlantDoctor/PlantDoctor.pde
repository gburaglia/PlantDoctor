import processing.serial.*;

Serial serial;  // Create object from Serial class
String val;     // Data received from the serial port
String [] valArray;
PImage welcomeScreen;
PImage plantScreen;
int systemState;
ArrayList<Rain> rainArray;
Plant firstPlant;
int timer;

void setup(){
   size(1280,800);
   welcomeScreen = loadImage("welcomeScreen.png");
   image(welcomeScreen, 0, 0);
   
   rainArray = new ArrayList<Rain>();
   systemState = 0;
   String portName = Serial.list()[2]; //change the right number based on your arduino
   serial = new Serial(this, portName, 9600);
   firstPlant =  new Plant(0.0, 0.0, 480);
   /*
   int step = 100;
  for(int i = 0; i < width/step; i++ ) 
     {
       line(i*step, 0, i*step, height);
       line(0, i*step, width, i*step);
     }
   */
   timer = millis();
    
}

void draw(){
 
  if (serial.available() > 0){  // If data is available, 
    readSerialValue();
  }
  
  
   if(systemState !=0)
   {
      if(firstPlant.isWaterNeeded())
     {
       showPlantScreen("plantScreen.png");
     }
      else
     {
       showNoWaterNeededScreen();
     }
   }
   if (systemState ==2)
   {
     if(firstPlant.isWaterNeeded() & timer < 300)
     {
       if(timer % 15==0)
       {
         createRain();
       }
       //for each loop to draw all rainArray objects
      for (Rain rainPart : rainArray)
      {
         rainPart.draw();
      }  
     }
     else if(firstPlant.isWaterNeeded()==false & timer < 100)
     {
       showNoWaterNeededScreen();
     }
     else {
       resetRain();
     }

     
   }
   timer = timer +1; 
   //println(systemState);
}

//creates a rain object each w/ many rain drops
void createRain()
{
  //each rain object is added to rainArray
  rainArray.add(new Rain(30));
}

void resetRain()
{
  //clear rainArray to start over
  rainArray.clear();
}

void mouseClicked()
{
  if (systemState == 0 & mouseX > 95 & mouseX < 400 & mouseY > 575 & mouseY < 650)
  {
    showPlantScreen("plantScreen.png");
    systemState = 1;
  } 
  else if (systemState != 0 & mouseX > 175 & mouseX < 575 & mouseY > 25 & mouseY < 150)
  {
    showNoWaterNeededScreen();
    systemState = 2;
    timer = 0;
  } 
     
}

void showPlantScreen(String backgroundFile){
  background(255);
  plantScreen = loadImage(backgroundFile);
  image(plantScreen, 0, 0);
  fill(0);
  textSize(48);
  text(int(firstPlant.plantHum),width-175,160);
  text(int(firstPlant.plantLight),width-175,500);
}

void showNoWaterNeededScreen(){
  showPlantScreen("plantScreenNoWater.png");
}

void readSerialValue(){
 
    val = serial.readStringUntil('\n');         // read it and store it in val
     if(val != null){
       if(match(val, ":")!= null)
      {
        
        valArray = split(val, " ");
         if(valArray.length > 6){
           firstPlant.updateLight(float(valArray[2]));
           firstPlant.updateHum(float(valArray[6]));
        }
      }
    } 
}
