class Plant
{
  float plantHum;
  float plantLight;
  float humLimit;
  
  Plant(float myPlantHum, float myPlantLight, float myHumLimit) 
  {
    plantHum = myPlantHum;
    plantLight = myPlantLight;
    humLimit = myHumLimit;
   }
   
   void updateHum(float humVal){
     plantHum = humVal;
   
   }
   
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
   
   void updateLight(float lightVal){
      plantLight = lightVal;
   }
   
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
  
  String assessLightLevel(){
     if(plantLight < 200)
     {
       return "Status: Too dark";
     }
     else if (plantLight > 600)
     {
       return "Status: Too light";
     }
     else
     {
       return "Status: Just right";
     }
  }
}
