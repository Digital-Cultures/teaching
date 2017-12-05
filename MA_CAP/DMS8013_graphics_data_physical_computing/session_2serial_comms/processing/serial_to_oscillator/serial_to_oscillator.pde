import processing.serial.*;

import processing.sound.*;

SawOsc saw;


Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph
PrintWriter output;
int inByte=0;

int gXpos;
int gYpos;
void setup () {
  // set the window size:
  size(400, 300);        

  // List all the available serial ports
  // I know that the first port in the serial list on my mac
  // is always my  Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[3], 9600);
  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
  // set inital background:
  saw = new SawOsc(this);

  //Start the Sine Oscillator. There will be no sound in the beginning
  //unless the mouse enters the   
  saw.play();
}
void draw () {
  // everything happens in the serialEvent()
  //drawGraph(inByte, color(255, 0, 0));
   saw.freq(map(inByte, 0, 1023, 80.0, 200.0));
}

void drawGraph(float aByte, color col) {
  int myByte =int( map(aByte, 0, 1023, 0, height));



  // draw the line:
  stroke(col);
  // line(xPos, height, xPos, height - inByte);
  point(xPos, height - myByte);
  gXpos = xPos;
  gYpos = height - (int)myByte;
  println(xPos, height - myByte);

  // at the edge of the screen, go back to the beginning:
  if (xPos >= width) {
    xPos = 0;
    background(0);
  } else {
    // increment the horizontal position:
    xPos++;
  }
}
void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {

    // trim off any whitespace:
    inString = trim(inString);

    if (inString.length()>0) {

      inByte = int(inString);
    }
  }
}