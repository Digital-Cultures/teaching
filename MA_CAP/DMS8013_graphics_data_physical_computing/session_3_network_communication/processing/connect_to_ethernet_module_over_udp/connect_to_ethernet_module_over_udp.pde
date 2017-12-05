//Processing sketch to send test UDP packets.

import hypermedia.net.*;

UDP udp;  // define the UDP object

String ip       = "192.168.1.101";  // the remote IP address
int port        = 1337;    // the destination port
void setup() {
  size(600,400);
  udp = new UDP( this, 6000 );  // create a new datagram connection on port 6000
  //udp.log( true );     // <-- printout the connection activity
  udp.listen( true );           // and wait for incoming message
}

void draw()
{
}

void keyPressed() {
  //change this to the arduino's IP


  udp.send("Greetings via UDP!", ip, port );   // the message to send
}
void mouseDragged() {
  float mappedMouse = map(mouseY,0,height,0,255);
  udp.send(str(mappedMouse), ip, port );
}

void receive( byte[] data ) {       // <-- default handler
  //void receive( byte[] data, String ip, int port ) {  // <-- extended handler

  for (int i=0; i < data.length; i++)
    print(char(data[i]));
  println();
}

