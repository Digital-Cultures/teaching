/**
ADAPTED FROM:
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
  BY TOM SCHOFIELD, DIGITAL CULTURES, CULTURE LAB CC 2016

 */
//share ethernet connection via wifi and connect to it from phone
 
import oscP5.*;
import netP5.*;

float x=0;
float y=0;
float z=0;
int xPos = 1; 
float gXpos;
float gYpos;
OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(400,400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,3333);
  background(0);

}


void draw() {
  //background(0);  
  fill(255);
  drawGraph(x, color(255,0,0));
  drawGraph(y, color(0,255,0));
  drawGraph(z, color(0,0,255));
}
void drawGraph(float inByte, color col) {
  inByte = map(inByte, -10, 10, 0, height);



  // draw the line:
  fill(col);
  noStroke();
  // line(xPos, height, xPos, height - inByte);
  ellipse(xPos, height - inByte,5,5);
  gXpos = xPos;
  gYpos = height - inByte;
  println(xPos, height - inByte);

  // at the edge of the screen, go back to the beginning:
  if (xPos >= width) {
    xPos = 0;
    background(0);
  } else {
    // increment the horizontal position:
    xPos++;
  }
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {

  if(theOscMessage.addrPattern().equals("/accelerometer/X") && theOscMessage.typetag().equals("f")){
    x = theOscMessage.get(0).floatValue();  
   // println("got",x);
  }
  if(theOscMessage.addrPattern().equals("/accelerometer/Y") && theOscMessage.typetag().equals("f")){
    y = theOscMessage.get(0).floatValue();  
  }
  if(theOscMessage.addrPattern().equals("/accelerometer/Z") && theOscMessage.typetag().equals("f")){
    z = theOscMessage.get(0).floatValue();  
  }
  
}
