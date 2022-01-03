import processing.serial.*;
import processing.video.*;
import java.util.Calendar;
import java.util.Date;

final char ENTER        = '4';
final char CURSORUP     = '5';
final char CURSORDOWN   = '6';
final char CURSORRIGHT  = '7';
final char CURSORLEFT   = '8';

Serial myPort;
Capture cam;
int index = 0;
int last = 366;

void setup() {
  size(640, 480);
  initSerial();
  initCam();
  println("Starting in 20 Seconds!");
  delay(20000);
}

void draw() {
  String pin = bruteForceDate();
  println("Testing " + pin);
  enterPin(pin);
  println("---");
  delay(400);
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  delay(100);
  save("index_" + nf(index-1, 4) + "_pin_" + pin + ".jpg");
}

void reset() {
  sendCommand(CURSORLEFT);
  sendCommand(CURSORLEFT);
  sendCommand(CURSORUP);
  sendCommand(CURSORUP);
  sendCommand(CURSORUP);
  sendCommand(CURSORUP);
}

void enterPin(String pin) {
  reset();
  int position = 0;
  for(int i = 0; i < pin.length(); i++) {
    int targetPos = Integer.valueOf(str(pin.charAt(i))) - 1;
    println("Entering: " + (targetPos+1));
    if(targetPos == -1) { // special handling for zero
      targetPos = 9;
    }
    position = moveCursor(position, targetPos);
    sendCommand(ENTER);
  }
  sendCommand(ENTER);
  println("Done");
}

int moveCursor(int currentPos, int targetPos) {
  int currentLevel = currentPos / 3;
  int targetLevel = targetPos / 3;
  
  // move down
  while(currentLevel < targetLevel) {
    sendCommand(CURSORDOWN);
    currentLevel++;
  }
  // move up
  while(currentLevel > targetLevel) {
    sendCommand(CURSORUP);
    currentLevel--;
  }
  
  int currentColumn = currentPos % 3;
  int targetColumn = targetPos % 3;
  
  // move left
  while(currentColumn > targetColumn) {
    sendCommand(CURSORLEFT);
    currentColumn--;
  }
  // move right
  while(currentColumn < targetColumn) {
    sendCommand(CURSORRIGHT);
    currentColumn++;
  }
  
  return targetPos;
}

void sendCommand(int command) {
  myPort.clear();
  for(int i = 0; i < 1; i++) {
    myPort.write(command);
    delay(25);
    myPort.write(10);
    delay(600);
  }
  myPort.readString();
}

void initCam() {
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      print(i + ": ");
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[2]);
    cam.start();     
  }
}

void initSerial() {
  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[0], 9600);
  //myPort.buffer(1);
  myPort.readString(); //clean the first buffer
  delay(3000);
}

String bruteForceDate() {
  int current = index++;
  if(current > last) {
    myPort.stop();
    println("All digits tested. Exit!");
    exit();
  }
  println("Index: " + current);
  Calendar cal = Calendar.getInstance();
  cal.set(Calendar.YEAR, 2004);
  cal.set(Calendar.MONTH, Calendar.JANUARY);
  cal.set(Calendar.DAY_OF_MONTH, current);
  int day = cal.get(Calendar.DAY_OF_MONTH);
  int month = cal.get(Calendar.MONTH) + 1;
  return nf(day, 2) + nf(month, 2);
}
