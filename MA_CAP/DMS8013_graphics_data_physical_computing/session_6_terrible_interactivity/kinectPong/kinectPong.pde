/*
Kinect Pong
Copyright (c) <2016> <Tom Schofield>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import controlP5.*;
import SimpleOpenNI.*;

SimpleOpenNI  context;
TSSkeleton skeleton;
ControlP5 cp5;

Paddle[] paddles;
Ball ball;
float timer=0;
DropdownList d1, d2, d3, d4;

int paddleSelector1=15;
int paddleSelector2=9;
String jointNames[];
int translations[];
boolean onePlayer=true;
PFont font;

void setup() {
  size(800, 500);
  ball= new Ball(width/2, height/2, new PVector(5, 5));
  rectMode(CENTER);
  paddles=new Paddle[2];
  paddles[0]= new Paddle(width-40, 20);
  paddles[1]= new Paddle(40, 20);

  setupContext();
  skeleton= new TSSkeleton();
  cp5 = new ControlP5(this);
//  cp5.addBang("restart").setPosition(350, 10).setSize(10, 10);

  d1 = cp5.addDropdownList("paddle1").setPosition(width-150, 20);
  d2 = cp5.addDropdownList("paddle2").setPosition(50, 20);
  d3 = cp5.addDropdownList("1_or_2_player").setPosition(150, 20);
  d4 = cp5.addDropdownList("speed").setPosition(250, 20);

  jointNames = loadStrings("joints.txt");

  d4.addItem("slow", 0);
  d4.addItem("fast", 1);
  d4.addItem("Jeez-us", 2);

  for (int i=0;i<jointNames.length;i++) {
    d1.addItem(jointNames[i], i);
    d2.addItem(jointNames[i], i);
  }

  d3.addItem("one player", 0);
  d3.addItem("two players", 1);

  smooth();
  println( "SimpleOpenNI.SKEL_HEAD "+SimpleOpenNI.SKEL_HEAD );
  println( "SimpleOpenNI.SKEL_LEFT_ANKLE "+SimpleOpenNI.SKEL_LEFT_FOOT );
//  println( "SimpleOpenNI.SKEL_LEFT_COLLAR "+SimpleOpenNI.SKEL_LEFT_COLLAR );
  println( "SimpleOpenNI.SKEL_LEFT_ELBOW "+SimpleOpenNI.SKEL_LEFT_ELBOW );
  println( "SimpleOpenNI.SKEL_LEFT_FINGERTIP "+SimpleOpenNI.SKEL_LEFT_FINGERTIP );
  println( "SimpleOpenNI.SKEL_LEFT_FOOT "+SimpleOpenNI.SKEL_LEFT_FOOT );
  println( "SimpleOpenNI.SKEL_LEFT_HAND "+SimpleOpenNI.SKEL_LEFT_HAND );
  println( "SimpleOpenNI.SKEL_LEFT_HIP "+SimpleOpenNI.SKEL_LEFT_HIP );
  println( "SimpleOpenNI.SKEL_LEFT_KNEE "+SimpleOpenNI.SKEL_LEFT_KNEE);
  println( "SimpleOpenNI.SKEL_LEFT_SHOULDER "+SimpleOpenNI.SKEL_LEFT_SHOULDER );
 // println( "SimpleOpenNI.SKEL_LEFT_WRIST "+SimpleOpenNI.SKEL_LEFT_WRIST );
  println( "SimpleOpenNI.SKEL_NECK "+SimpleOpenNI.SKEL_NECK );
  println( "SimpleOpenNI.SKEL_RIGHT_ANKLE "+SimpleOpenNI.SKEL_RIGHT_FOOT );
//  println( "SimpleOpenNI.SKEL_RIGHT_COLLAR "+SimpleOpenNI.SKEL_RIGHT_COLLAR );
  println( "SimpleOpenNI.SKEL_RIGHT_ELBOW "+SimpleOpenNI.SKEL_RIGHT_ELBOW );
  println( "SimpleOpenNI.SKEL_RIGHT_FINGERTIP "+SimpleOpenNI.SKEL_RIGHT_FINGERTIP );
  println( "SimpleOpenNI.SKEL_RIGHT_FOOT "+SimpleOpenNI.SKEL_RIGHT_FOOT );
  println( "SimpleOpenNI.SKEL_RIGHT_HAND  "+SimpleOpenNI.SKEL_RIGHT_HAND );
  println( "SimpleOpenNI.SKEL_RIGHT_HIP "+SimpleOpenNI.SKEL_RIGHT_HIP );
  println( "SimpleOpenNI.SKEL_RIGHT_KNEE "+SimpleOpenNI.SKEL_RIGHT_KNEE );
  println( "SimpleOpenNI.SKEL_RIGHT_SHOULDER "+SimpleOpenNI.SKEL_RIGHT_SHOULDER );
 // println( "SimpleOpenNI.SKEL_RIGHT_WRIST "+SimpleOpenNI.SKEL_RIGHT_WRIST );
  println( "SimpleOpenNI.SKEL_TORSO "+SimpleOpenNI.SKEL_TORSO );
  //println( "SimpleOpenNI.SKEL_WAIST "+SimpleOpenNI.SKEL_WAIST );

  translations=new int[jointNames.length];
  translations[0]=SimpleOpenNI.SKEL_HEAD ;
  translations[1]= SimpleOpenNI.SKEL_LEFT_FOOT;
  translations[2]=5 ;
  translations[3]=SimpleOpenNI.SKEL_LEFT_ELBOW ;
  translations[4]=SimpleOpenNI.SKEL_LEFT_FINGERTIP ;
  translations[5]= SimpleOpenNI.SKEL_LEFT_FOOT ;
  translations[6]=SimpleOpenNI.SKEL_LEFT_HAND ;//9 ;
  translations[7]=SimpleOpenNI.SKEL_LEFT_HIP ;
  translations[8]=SimpleOpenNI.SKEL_LEFT_KNEE ;
  translations[9]=SimpleOpenNI.SKEL_LEFT_SHOULDER ;
  translations[10]=8 ;
  translations[11]=SimpleOpenNI.SKEL_NECK ;
  translations[12]=SimpleOpenNI.SKEL_RIGHT_FOOT ;
  translations[13]= 11;
  translations[14]=SimpleOpenNI.SKEL_RIGHT_ELBOW ;
  translations[15]= SimpleOpenNI.SKEL_RIGHT_FINGERTIP;
  translations[16]= SimpleOpenNI.SKEL_RIGHT_FOOT;
  translations[17]= SimpleOpenNI.SKEL_RIGHT_HAND;
  translations[18]= SimpleOpenNI.SKEL_RIGHT_HIP;
  translations[19]= SimpleOpenNI.SKEL_RIGHT_KNEE;
  translations[20]= SimpleOpenNI.SKEL_RIGHT_SHOULDER;
  translations[21]= 14;
  translations[22]= SimpleOpenNI.SKEL_TORSO;
//  translations[23]= SimpleOpenNI.SKEL_WAIST;
  for(int i=0;i<translations.length;i++){
   println( jointNames[i], translations[i]);
  }
  font=loadFont("AlBayan-48.vlw");
  textFont(font, 48);
}

void keyPressed(){
  if(key=='n'){
    paddles[0].points = 0;
    paddles[1].points = 0;
  }
}

void draw() {
  background(0);
  fill(0, 255, 0);
  stroke(255);
  // get kinect color image
  context.update();
  // scale to an arbitrary size and position (e.g. scale down 75%, and align to bottom / center)
  skeleton.updateSkeleton();


  if (onePlayer) {
    paddles[0].update(skeleton.getScreenCoords(1, paddleSelector1).y);
    paddles[1].update(skeleton.getScreenCoords(1, paddleSelector2).y);
  }
  else {
    paddles[0].update(skeleton.getScreenCoords(1, paddleSelector1).y);
    try {
      paddles[1].update(skeleton.getScreenCoords(2, paddleSelector2).y);
    }
    catch(Exception e) {
    }
  }

  for (int i=0;i<paddles.length;i++) {

    paddles[i].drawPaddle();
  }
  ball.update();
  ball.checkCollision(paddles);
  ball.drawBall();

  /*PVector rHand = skeleton.getScreenCoords(1, SimpleOpenNI.SKEL_RIGHT_HAND) ;
   PVector lHand = skeleton.getScreenCoords(1, SimpleOpenNI.SKEL_LEFT_HAND) ;
   fill(255, 0, 0);
   ellipse(rHand.x, rHand.y, 20, 20);
   ellipse(lHand.x, lHand.y, 20, 20);*/
  float offset=80;
  text(str(paddles[0].points), width-(offset+(0.5*textWidth(str(paddles[0].points)))), height -50);
  text(str(paddles[1].points), offset, height -50);
  fill(0, 255, 0, 255 -( (255/(timer+1)) *(timer+1)));

  if (timer>0) {
    String txt="POINT";
    text(txt, (width/2)-(0.5*textWidth(txt)), height/2);
    timer--;
  }
}

void setupContext() {
  //setup onenNI context
  context = new SimpleOpenNI(this);
  // enable depthMap generation 
  context.enableDepth();
  // enable camera image generation
  context.enableRGB();
  context.setMirror(true);

  // enable skeleton generation for all joints
  context.enableUser();//SimpleOpenNI.SKEL_PROFILE_ALL);
  stroke(255, 255, 255);
  smooth();
}


//OPENNI CALLBACKS
//void onNewUser(int userId)
//{
//  println("onNewUser - userId: " + userId);
//  println("  start pose detection");
//
//  context.startTrackingSkeleton(userId);
//  //context.requestCalibrationSkeleton(userId, true);
//}
void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  curContext.startTrackingSkeleton(userId);
}

void onLostUser(int userId)
{
  println("onLostUser - userId: " + userId);
}

void onExitUser(int userId)
{
  println("onExitUser - userId: " + userId);
}

void onReEnterUser(int userId)
{
  println("onReEnterUser - userId: " + userId);
}


void onStartCalibration(int userId)
{
  println("onStartCalibration - userId: " + userId);
}

void onEndCalibration(int userId, boolean successfull)
{
  println("onEndCalibration - userId: " + userId + ", successfull: " + successfull);

  if (successfull) 
  { 
    println("  User calibrated !!!");
    context.startTrackingSkeleton(userId);
  } 
  else 
  { 
    println("  Failed to calibrate user !!!");
    println("  Start pose detection");
 //   context.startPoseDetection("Psi", userId);
  }
}

void onStartPose(String pose, int userId)
{
  println("onStartdPose - userId: " + userId + ", pose: " + pose);
  println(" stop pose detection");

 // context.stopPoseDetection(userId); 
 // context.requestCalibrationSkeleton(userId, true);
}

void onEndPose(String pose, int userId)
{
  println("onEndPose - userId: " + userId + ", pose: " + pose);
}

void controlEvent(ControlEvent theEvent) {
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.

/*  if (theEvent.getController().getName().equals("restart")) {
    paddles[0].points=0;
    paddles[1].points=0;
  }*/

  if (theEvent.isController()) {
    // check if the Event was triggered from a ControlGroup
    //  println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
    if (theEvent.getController().toString().equals("paddle1 [DropdownList]")) {
      println("paddle1 "+theEvent.getController().getValue());
      paddleSelector1 = translations[(int) theEvent.getController().getValue()];
      println(jointNames[paddleSelector1]);
    }
    else if (theEvent.getController().toString().equals("paddle2 [DropdownList]")) {
      println("paddle2 "+theEvent.getController().getValue());
      paddleSelector2 = translations[(int)theEvent.getController().getValue()];
      println(jointNames[paddleSelector2]);
    }
    else if (theEvent.getController().toString().equals("1_or_2_player [DropdownList]")) {
      println("choosing num players");
      if ((int)theEvent.getController().getValue()==0) {
        onePlayer=true;
      }
      else {
        onePlayer=false;
      }
    }
    else if (theEvent.getController().toString().equals("speed [DropdownList]")) {
      if ((int)theEvent.getController().getValue()==0) {
        ball.speed=new PVector(5, 5);
      }
      else if ((int)theEvent.getController().getValue()==1) {
        ball.speed=new PVector(10, 10);
      }
      else if ((int)theEvent.getController().getValue()==2) {
        ball.speed=new PVector(15, 15);
      }
    }
  } 
  else if (!theEvent.isController()) {
    println("event from controller no matches : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  }
}

