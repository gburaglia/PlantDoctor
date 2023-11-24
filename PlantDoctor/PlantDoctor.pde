import processing.serial.*;

Serial serial;  // Create object from Serial class
String val;     // Data received from the serial port
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
   /*
   String portName = Serial.list()[2]; //change the right number based on your arduino
   serial = new Serial(this, portName, 9600);
   */
   firstPlant =  new Plant(50, 0.0, 100);
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
  
  /*
  if (serial.available() > 0){  // If data is available, 
    readSerialValue();
  }
  */
  
   if(systemState !=0)
   {
      
      showPlantScreen();
      
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
   println(systemState);
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
  if (systemState == 0 & mouseX > 450 & mouseX < 850 & mouseY > 525 & mouseY < 625)
  {
    showPlantScreen();
    systemState = 1;
  } 
  else if (systemState != 0 & mouseX > 100 & mouseX < 400 & mouseY > 0 & mouseY < 100)
  {
    showPlantScreen();
    systemState = 2;
    timer = 0;
  } 
     
}

void showPlantScreen(){
  background(255);
  plantScreen = loadImage("plantScreen.jpg");
  image(plantScreen, 0, 0);
  fill(0);
  text("Plant Humidity: " + firstPlant.plantLight,width-200,100);
  text("Plant Light: " + firstPlant.plantLight,width-200,200);
}

void showNoWaterNeededScreen(){
  background(255);
}

void readSerialValue(){
  
    val = serial.readStringUntil('\n');         // read it and store it in val
    
    if(val != null){
      if(match(val, "Humidity:") != null & firstPlant.plantHum != float(val))
      {
         firstPlant.updateHum(float(val));
      }
      else if(match(val, "Light:") != null & firstPlant.plantLight != float(val))
      {
        firstPlant.updateLight(float(val));
      }
    }
     
}
