/*
  LiquidCrystal Library - display() and noDisplay()

  Demonstrates the use a 16x2 LCD display.  The LiquidCrystal
  library works with all LCD displays that are compatible with the
  Hitachi HD44780 driver. There are many of them out there, and you
  can usually tell them by the 16-pin interface.

  This sketch prints "Hello World!" to the LCD and uses the
  display() and noDisplay() functions to turn on and off
  the display.

  The circuit:
   LCD RS pin to digital pin 12
   LCD Enable pin to digital pin 11
   LCD D4 pin to digital pin 5
   LCD D5 pin to digital pin 4
   LCD D6 pin to digital pin 3
   LCD D7 pin to digital pin 2
   LCD R/W pin to ground
   10K resistor:
   ends to +5V and ground
   wiper to LCD VO pin (pin 3)

  Library originally added 18 Apr 2008
  by David A. Mellis
  library modified 5 Jul 2009
  by Limor Fried (http://www.ladyada.net)
  example added 9 Jul 2009
  by Tom Igoe
  modified 22 Nov 2010
  by Tom Igoe
  modified 7 Nov 2016
  by Arturo Guadalupi
  modified 1 Dec 2017 
  by Tom Schofield


*/

// include the library code:
#include <LiquidCrystal.h>
String inputString = "";         // a string to hold incoming data
boolean stringComplete = false;  // whether the string is complete
// initialize the library by associating any needed LCD interface pin
// with the arduino pin number it is connected to
const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 3, d7 = 2;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);
String displayText = "";

int count = 0;
void setup() {
  // set up the LCD's number of columns and rows:
  lcd.begin(16, 2);
  // Print a message to the LCD.
  // lcd.print("hello, world!i am a sausage");
  Serial.begin(9600);
  // reserve 200 bytes for the inputString:q
  inputString.reserve(500);
  // lcd.autoscroll();
  //Serial.println(1);
  lcd.print("waiting for message");
  delay(1000);
  count = 1;
  Serial.println(1);
}
void loop() {

  if (stringComplete) {
   
    // clear the string:
    inputString = "";
    stringComplete = false;



    //get number of lines
    //
    int numLines = displayText.length() / 16;
    //see if there's a remainder and add a line if so
    if (displayText.length() % numLines != 0) numLines++;

    //split the text into chunks using substring
    for (int i = 0; i < numLines;i++) {
      lcd.setCursor(0, 0);
      lcd.print(displayText.substring(i * 16, (i + 1) * 16));
      lcd.setCursor(0, 1);
      lcd.print(displayText.substring((i + 1) * 16, (i + 2) * 16));
      delay(1500);
      lcd.clear();
      
    }
    //send a message back to say that we're done
    Serial.println(1);
 
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
      displayText = inputString;
      lcd.clear();
    }
  }
}

