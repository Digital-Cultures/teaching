/*
Copyright <2017> <Tom Schofield> 'recreating listening post' 
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

//grab our libraries
import http.requests.*;
import java.io.*;
import processing.serial.*;
import oscP5.*;
import netP5.*;

NetAddress remote;
OscP5 oscP5;

Serial myPort;
//holds incoming serial data
int serialData = 0;
PFont font;
//rely on saved data or live from reddit?
boolean loadLive = true;
//which title are we on
int index = 0;

//our list of reddit titles
ArrayList titles;

//what's the current title we want to draw to screen
String currentText="";

//have we got new data
boolean go= false;

void setup() 
{
  oscP5 = new OscP5(this, 12000);
  remote = new NetAddress("127.0.0.1", 3000);

  ///our list of titles
  titles = new ArrayList();
  font = loadFont("AmericanTypewriter-48.vlw");
  textFont(font, 16);
  size(800, 150);
  smooth();
  //just for info (and choosig your serial port)
  println( Serial.list());
  myPort = new Serial(this, Serial.list()[2], 9600);
  myPort.bufferUntil('\n');
  //alll the data getting stuff
  JSONObject response;
  String searchTerm = "brexit";

  if (loadLive) {
    //construct the query
    GetRequest get = new GetRequest("https://www.reddit.com/search.json?q="+searchTerm);
    get.send(); // program will wait untill the request is completed
    response = parseJSONObject(get.getContent());
  } else {
    //or just load it from file
    response = loadJSONObject("reddit.json");
  }


  JSONObject data = response.getJSONObject("data");
  JSONArray children = data.getJSONArray("children");

  for (int i=0; i<children.size(); i++) {
    JSONObject child = children.getJSONObject(i);
    JSONObject childData = child.getJSONObject("data");
    String title = childData.getString("title");
    //println(title);
    titles.add(title);
  }
  //get our first sentence
  currentText = (String)titles.get(index);
  // println(children);
}


void draw() {
  background(0);
  fill(0, 244, 255);
  text (currentText, 10, height*0.25, width-10, height*0.5);
  if (go) {
    index ++;

    if (index>=titles.size()) {
      index = 0;
    }
    currentText = (String)titles.get(index);
    myPort.write(currentText+"\n");
    say(currentText);
    go=false;
  }
}

//function which calls 'say' terminal command on a mac
void say(String what) {
  Process p;

  try {
    Process sayWhat = Runtime.getRuntime().exec("say "+what);
  }
  catch(Exception e) {
    println(e);
  }
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  //ok we have new data - lets go!
  go= true;
  serialData = int(trim(inString));
  OscMessage msg = new OscMessage("/fromProcessing");
  msg.add(1);
  oscP5.send(msg, remote);
}