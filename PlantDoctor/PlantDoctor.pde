PImage welcomeScreen;
PImage plantScreen;
int systemState;
RainDrop newDrop;
ArrayList<Rain> rainArray = new ArrayList<Rain>();
int timer;
void setup(){
   size(1280,800);
   welcomeScreen = loadImage("welcomeScreen.png");
   image(welcomeScreen, 0, 0);
   systemState = 0;
   
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
  
   if(systemState !=0)
   {
      showPlantScreen();
      
   }
   if (systemState ==2)
   {

     //for each loop to draw all rainArray objects
      for (Rain rainPart : rainArray)
      {
         rainPart.draw();
      }  
      timer = timer +1; 
     if( timer % 15==0)
     {
       createRain();
     }
   }
   
   
}

//creates a rain object each w/ many rain drops
void createRain()
{
  //each rain object is added to rainArray
  rainArray.add(new Rain(30));
}

void mouseClicked()
{
  if (systemState == 0 & mouseX > 450 & mouseX < 850 & mouseY > 525 & mouseY < 625)
  {
    showPlantScreen();
    systemState = 1;
  } 
  else if (systemState == 1 & mouseX > 100 & mouseX < 400 & mouseY > 0 & mouseY < 100)
  {
    showPlantScreen();
    systemState = 2;
  } 
     
}

void showPlantScreen(){
  background(255);
  plantScreen = loadImage("plantScreen.jpg");
  image(plantScreen, 0, 0);
  text("Hello",width/2,height/2);
}
