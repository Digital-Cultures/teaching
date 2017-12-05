/*
  send Analogue over UDP

 created Feb 2016
 by Tom Schofield

 This code is in the public domain.
 */


#include <SPI.h>         // needed for Arduino versions later than 0018
#include <Ethernet.h>
#include <EthernetUdp.h>         // UDP library from: bjoern@cs.stanford.edu 12/30/2008


// Enter a MAC address and IP address for your controller below.
// The IP address will be dependent on your local network: (you can also add DHCP if that takes your fancy)

byte mac[] = {
  0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED
};
IPAddress ip(192, 168, 1, 177);

unsigned int localPort = 8888;      // local port to listen on
char * clientIP = "192.168.1.101";
// buffers for receiving and sending data
char packetBuffer[UDP_TX_PACKET_MAX_SIZE]; //buffer to hold incoming packet,
// An EthernetUDP instance to let us send and receive packets over UDP
EthernetUDP Udp;

void setup() {
  // start the Ethernet and UDP:
  Ethernet.begin(mac, ip);
  Udp.begin(localPort);

  Serial.begin(9600);
}

void loop() {
  int reading = analogRead(A0);

  Udp.beginPacket(clientIP, 9000);
  Udp.write(reading);
  Udp.endPacket();
  delay(10);
}


