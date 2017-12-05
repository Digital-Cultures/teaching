
/*
  //adapted from
  Reading a serial ASCII-encoded string.
  created 13 Apr 2012
  by Tom Igoe

  It looks for an ASCII string of comma-separated values.
  and uses them to write to a max 7219 led driver chip
*/
#include "LedControl.h"
String inputString = "";         // a string to hold incoming data
boolean stringComplete = false;

LedControl lc = LedControl(12, 11, 10, 1);
int row = 0;
int col = 7;
int arrayIndex = 0;

void setup() {
  // initialize serial:
  Serial.begin(9600);
  inputString.reserve(200);
  // make the pins outputs:
  lc.shutdown(0, false);
  /* Set the brightness to a medium values */
  lc.setIntensity(0, 8);
  /* and clear the display */
  lc.clearDisplay(0);
}

void loop() {

  if (stringComplete) {
    Serial.println("string"+inputString);
    // Serial.println(inputString);
    lc.setRow(0, row , inputString.toInt());
    row++;
    if (row >= 8) {
      row = 0;
    }
    inputString = "";
    stringComplete = false;
  }
}


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






