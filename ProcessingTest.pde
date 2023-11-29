import processing.serial.*;

Serial serial;
String val;
float soilMoisture;

int duration;
int timePassed;
int timeLeft;

boolean isStartMode;

void setup() {
  String portName = Serial.list()[3];
  serial = new Serial(this, portName, 9600);
  timePassed = millis();
  timeLeft = duration = 10;
  isStartMode = false;
}

boolean isDry(float val) {
  return (val > 480 && val <= 590);
}

void draw() {
  println("The Start Mode is: " + isStartMode);
  if (mousePressed) {
    isStartMode = !isStartMode;
  }
  if (serial.available() > 0) {
    val = serial.readStringUntil('\n');
    
    if (val != null) {
      //println(val);
      soilMoisture = float(val);
      println(soilMoisture);
    }
  }
  
  if (isStartMode && isDry(soilMoisture) && timeLeft > 0) {
    serial.write('1');
    timeLeft = duration - (millis() - timePassed)/1000;
    println("The time left is: " + timeLeft);
  }
  else {
    serial.write('0'); 
    timePassed = millis();
    timeLeft = duration;
    isStartMode = false;
  }
  

}
