class Rain //collection of rain drop objects
{
  RainDrop [] droplets;
  Rain(int numOfDroplets)
  {
    droplets = new RainDrop[numOfDroplets];
    for (int i = 0; i < droplets.length; i = i+1)
    {
      droplets[i] = new RainDrop(int(random(0,width)),-height/2,random(3,8),random(5,8));
    }
  }
  
  void draw(){
    for (int i = 0; i < droplets.length; i = i+1)
    {
      droplets[i].draw();
     }
  }
}
