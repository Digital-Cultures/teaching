/**
 ADAPTED FROM:
 
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 BY TOM SCHOFIELD, DIGITAL CULTURES, CULTURE LAB
 demonstrates how to get OSC from https://itunes.apple.com/us/app/clean-osc/id1235192209?mt=8
 or http://sensors2.org 
 
 into processing
 */

import oscP5.*;
import netP5.*;


OscP5 oscP5;
NetAddress myRemoteLocation;

float hue = 0;

void setup() {
  size(400, 400);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12000);

  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  //where do we want to send the messages to?
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
  colorMode(HSB);
}


void draw() {
  background(hue,255,255); 
  
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  println("got message",theOscMessage.addrPattern(),theOscMessage.typetag() );
  //check the message fits the expected pattern
  
    //if you add a clean_slider in  Clean OsC
   if (theOscMessage.addrPattern().equals("/clean_slider_1") && theOscMessage.typetag().equals("f")) {
    hue = map(theOscMessage.get(0).floatValue(),0,1,0,360);
    println(hue);
   }
   //or select accelerometer data in sensors2OSC
   if (theOscMessage.addrPattern().equals("/accelerometer/X") && theOscMessage.typetag().equals("f")) {
    hue = map(theOscMessage.get(0).floatValue(),-50,50,0,360);
    println(theOscMessage.get(0).floatValue());
   }
   
}