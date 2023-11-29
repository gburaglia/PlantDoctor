import processing.serial.*;

Serial serial;
String val;
float soilMoisture;
void setup() {
  String portName = Serial.list()[3];
  serial = new Serial(this, portName, 9600);
}

void draw() {
  if (mousePressed) {
    serial.write('1');
  }
  else {
    serial.write('0'); 
  }
  
  if (serial.available() > 0) {
    val = serial.readStringUntil('\n');
    
    if (val != null) {
      //println(val);
      soilMoisture = float(val);
      println(soilMoisture);
    }
  }
}
