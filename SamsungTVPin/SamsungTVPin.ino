#include <IRremote.h>

const long POWER        = 0xE0E040BF;
const long INFO         = 0xE0E0F807;
const long FACTORY      = 0xE0E0DC23;
const long THREESPEED   = 0xE0E03CC3;
const long VOLUP        = 0xE0E0E01F;
const long VOLDOWN      = 0xE0E0D02F;
const long ENTER        = 0xE0E016E9;
const long CURSORUP     = 0xE0E006F9;
const long CURSORDOWN   = 0xE0E08679;
const long CURSORRIGHT  = 0xE0E046B9;
const long CURSORLEFT   = 0xE0E0A659;

const int SEND_PIN = 3;
IRsend irsend(SEND_PIN);

void setup() {
  Serial.begin(9600);
}

void loop() {
    while(Serial.available() > 0)  {
      int incomingData= Serial.read(); // can be -1 if read error
      switch(incomingData) { 
      case '1':
        irsend.sendSAMSUNG(VOLUP, 32);
        irsend.sendSAMSUNG(VOLUP, 32);
         break;
      case '2':
        irsend.sendSAMSUNG(VOLDOWN, 32);
        irsend.sendSAMSUNG(VOLDOWN, 32);
         break;
      case '3':
        irsend.sendSAMSUNG(INFO, 32);
        irsend.sendSAMSUNG(INFO, 32);
         break;
      case '4':
        irsend.sendSAMSUNG(ENTER, 32);
        irsend.sendSAMSUNG(ENTER, 32);
         break;
      case '5':
        irsend.sendSAMSUNG(CURSORUP, 32);
        irsend.sendSAMSUNG(CURSORUP, 32);
         break;
      case '6':
        irsend.sendSAMSUNG(CURSORDOWN, 32);
        irsend.sendSAMSUNG(CURSORDOWN, 32);
         break;
      case '7':
        irsend.sendSAMSUNG(CURSORRIGHT, 32);
        irsend.sendSAMSUNG(CURSORRIGHT, 32);
         break;
      case '8':
        irsend.sendSAMSUNG(CURSORLEFT, 32);
        irsend.sendSAMSUNG(CURSORLEFT, 32);
         break;
      }
      Serial.print("Got Command: ");
      Serial.println(incomingData);
    }
}
