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
     if(plantHum > 480 && plantHum < 540)
     {
       return "Status: Too dry";
     }
     else if (plantHum > 200 && plantHum < 240)
     {
       return "Status: Too wet";
     }
     else
     {
       return "Status: Just right";
     }
  }
  
  // Returns text description for water level status
  String assessLightLevel(){
     if(plantLight < 500)
     {
       return "Status: Too dark";
     }
     else if (plantLight > 800)
     {
       return "Status: Too light";
     }
     else
     {
       return "Status: Just right";
     }
  }
}
