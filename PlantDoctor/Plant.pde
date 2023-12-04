class Plant // Plant object class
{
  // Humidity and light values
  float plantHum;
  float plantLight;
  float humLimit;
  
  // Plant object constructor 
  Plant(float myPlantHum, float myPlantLight, float myHumLimit) 
  {
    plantHum = myPlantHum;
    plantLight = myPlantLight;
    humLimit = myHumLimit;
   }
   
   // Updates humidity value
   void updateHum(float humVal){
     plantHum = humVal;
   }
   
   // Defines if water is needed based on initial humidity value
   boolean isWaterNeeded(){
     if(plantHum <= humLimit)
     {
       return false;
     }
     else 
     {
       return true;
     }
   
   }
   
   // Updates light value
   void updateLight(float lightVal){
      plantLight = lightVal;
   }
   
   // Returns text description for water level status
   String assessWaterLevel(){
     if(plantHum > 480)
     {
       return "Dry, needs water";
     }
     else if (plantHum >= 240 && plantHum <= 480)
     {
       return "Ideal soil moisture";
     }
     else
     {
       return "Too wet";
     }
  }
  
  // Returns text description for water level status
  String assessLightLevel(){
     if(plantLight > 700)
     {
       return "Room is too bright";
     }
     else if (plantLight >= 300 && plantLight <= 700)
     {
       return "Ideal brightness";
     }
     else
     {
       return "Room is too dark";
     }
  }
}
