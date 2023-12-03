class RainDrop // Single rain drop objects
{
  // Rain drop obj properties
  float yposition;
  float xposition;
  float size;
  color c;
  float speed;
 
 // Rain drop constructor
  RainDrop(int myX, int myY, float mySpeed, float mySize) {
    xposition = myX;
    yposition = myY;
    size = mySize;
    c = 0;
    speed = mySpeed; 
  }

  // Draw a single raindrop
  void draw() {
    noStroke();
    fill(#89CFF0);
    // Rain drop is several overlapping ellipses
    // # of ellipses depends on rain drop size
    for (int i = 2; i < size; i++ ) {
      ellipse(xposition, yposition + i*4,i*2,i*2);
    }
    // Moves raindrop down the screen at given speed
     yposition += speed;
     
     // Sets raindrop color
     fill(c);
  }
}
