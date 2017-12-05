/**
ADAPTED FROM:
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
  BY TOM SCHOFIELD, DIGITAL CULTURES, CULTURE LAB

 */
 
import oscP5.*;
import netP5.*;

int x=0;
int y=0;
 
OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(400,400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,1200);
  background(0);

}


void draw() {
  //background(0);  
  fill(255);
  ellipse(x,y,5,5);
  
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {

  //check the message fits the expected pattern
  if(theOscMessage.addrPattern().equals("/mousePos") && theOscMessage.typetag().equals("ii")){
    x = theOscMessage.get(0).intValue();  
    y = theOscMessage.get(1).intValue();  
  }
  
}
