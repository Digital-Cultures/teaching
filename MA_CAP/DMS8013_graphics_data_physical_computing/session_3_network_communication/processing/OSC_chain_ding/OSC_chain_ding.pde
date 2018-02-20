/**
 ADAPTED FROM:
 
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 BY TOM SCHOFIELD, DIGITAL CULTURES, CULTURE LAB
 
 for use in class demo- each person takes the ip address of the person to their right. This should result in a circular ding travellign around the group
 */

import oscP5.*;
import netP5.*;

import ddf.minim.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer groove;

OscP5 oscP5;
NetAddress myRemoteLocation;


//management messages
boolean gotMessage = false;
boolean sendMessage = false;

//how to start the timer
long startTime = 0;
long interval = 2000;

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

  //create the minim object
  minim = new Minim(this);
  groove = minim.loadFile("ding.wav", 2048);
}


void draw() {
  background(0); 

  ///on a new message
  if (gotMessage) {
    ///play the track
    groove.play();
    //set our flag to false so we know that next time round the loop, if it's true that means we ahve a new message
    gotMessage = false;
    //start our time
    startTime = millis();
    //get ready to send
    sendMessage = true;
  }

  //if the sample is playing, show the text
  if (groove.isPlaying()) text("ding", width/2, height/2);

  //if our timer is up
  if (millis()-startTime>interval) {
    //and if we haven't sent the message yet
    if (sendMessage) {

      //send the message
      OscMessage myMessage = new OscMessage("/ding");

      myMessage.add(1);
      oscP5.send(myMessage, myRemoteLocation);
      //but don't send it twice
      sendMessage = false;
      //rewind the sample
      groove.rewind();
    }
  }
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  println("got message", theOscMessage.addrPattern());
  //check the message fits the expected pattern
  if (theOscMessage.addrPattern().equals("/ding") && theOscMessage.typetag().equals("i")) {
    gotMessage = true;
  }
}

//someone has to start things off!
void keyPressed() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/ding");

  myMessage.add(1); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
}