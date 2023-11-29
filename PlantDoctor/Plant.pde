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
       return "Too dry";
     }
     else if (plantHum > 200 && plantHum < 240)
     {
       return "Too wet";
     }
     else
     {
       return "Just right";
     }
}
