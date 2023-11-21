class RainDrop //single rain drop objects
{
  //rain drop obj properties
  float yposition;
  float xposition;
  float size;
  color c;
  float speed;
 
 //rain drop constructor
  RainDrop(int myX, int myY, float mySpeed, float mySize) {
    xposition = myX;
    yposition = myY;
    size = mySize;
    c = 0;
    speed = mySpeed; 
  }

  //draw raindrop
  void draw() {
    noStroke();
    //rain drop is several overlapping ellipses
    //# of ellipses depends on rain drop size
    for (int i = 2; i < size; i++ ) {
      ellipse(xposition, yposition + i*4,i*2,i*2);
    }
    //moves raindrop down the screen
     yposition += speed;
     
     //sets raindrop color
     fill(c);
  }

}
