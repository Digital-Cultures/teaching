
#include "LedControl.h"
LedControl lc=LedControl(12,11,10,1);

int intensity = 15;

String inputString = "";         // a string to hold incoming data
boolean stringComplete = false;  // whether the string is complete
int row= 0;
void setup() {
  // initialize serial:
  Serial.begin(9600);
  // reserve 200 bytes for the inputString:
  inputString.reserve(200);
  lc.shutdown(0, false);
  /* Set the brightness to a medium values */
  lc.setIntensity(0, intensity);
  /* and clear the display */
  lc.clearDisplay(0);
}

void loop() {
  // print the string when a newline arrives:
  if (stringComplete) {
    Serial.print("received: ");
    //String msg = "this";
    Serial.println(inputString);
    //byte aByte = Serial.read();
     lc.setRow(0,row,inputString.toInt());
      row++;
      if(row>=8){
       row=0; 
      }
    // clear the string:
    inputString = "";
    stringComplete = false;
  }
}

/*
  SerialEvent occurs whenever a new data comes in the
  hardware serial RX.  This routine is run between each
  time loop() runs, so using delay inside loop can delay
  response.  Multiple bytes of data may be available.
*/
void serialEvent() {
  while (Serial.available()) {
    // get the new byte:
    char inChar = (char)Serial.read();
    // add it to the inputString:
    inputString += inChar;
    // if the incoming character is a newline, set a flag
    // so the main loop can do something about it:
    if (inChar == '\n') {
      stringComplete = true;
    }
  }
}


