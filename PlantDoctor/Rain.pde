class Rain // Collection of rain drop objects
{
  RainDrop [] droplets;
  
  // Rain constructor
  Rain(int numOfDroplets)
  {
    droplets = new RainDrop[numOfDroplets];
    for (int i = 0; i < droplets.length; i = i+1)
    {
      //makes rain drops at random positions, with random speeds
      droplets[i] = new RainDrop(int(random(0,width)),int(random(-height/2,height/2)),random(5,10),random(5,8));
    }
  }
  
  //Draws all rain drops in rain collection
  void draw(){
    for (int i = 0; i < droplets.length; i = i+1)
    {
      droplets[i].draw();
     }
  }
}
