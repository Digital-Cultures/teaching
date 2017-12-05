import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

PImage orange;


// contrast/brightness values
float contrast_value    = 1;
int brightness_value  = 0;



void setup() {

  size(640, 480 );
  orange= loadImage("orange.png");
  video = new Capture(this, width, height);

  opencv = new OpenCV(this, width, height);

  // opencv.capture( width, height );                   // open video stream
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
  // print usage
  println( "Drag mouse on X-axis inside this sketch window to change contrast" );
  println( "Drag mouse on Y-axis inside this sketch window to change brightness" );
}



void draw() {

  // grab a new frame
  opencv.loadImage(video);

  //set the contrast and brightness to our variables
  opencv.contrast( contrast_value );
  opencv.brightness( brightness_value );

  // do detection
  Rectangle[] faces = opencv.detect( );
  //we actually want to change these parameters but it doesn't seem to be implemented int his version
  //Rectangle[] faces = opencv.detect(1.2, 2, OpenCV.HAAR_DO_CANNY_PRUNING, 40, 40 );

  // display the image that cv is actually seeing
  PImage cvimage = opencv.getOutput();
  //image( video, 0, 0 );
  image(cvimage, 0, 0);



  // draw face area(s) 
  //if (faces.length > 0) {
  // for (int i=0; i<faces.length; i++) {
  //   image(orange, faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  // }
  //}
  //if there are exactly 2 faces
  if (faces.length == 2) {
    
    
    int x0 = faces[0].x;
    int y0 = faces[0].y;
    
    int x1 = faces[1].x;
    int y1 = faces[1].y;
    
   PImage face0 = video.get(x0,y0,100,100);
   PImage face1 = video.get(x1,y1,100,100);
   
   image(face0,x1,y1);
   image(face1, x0,y0);
   
    
  }

  //draw debugging text to the screen
  fill(255, 0, 0);
  text("Contrast: "+contrast_value +" \nBrightness: "+ brightness_value, 50, 50);
  loadPixels();
}


/**
 * Changes contrast/brigthness values
 */
void mouseDragged() {
  contrast_value   = map( mouseX, 0, width, 0, 1 );
  brightness_value = (int) map( mouseY, 0, height, 0, 255 );
  println(contrast_value, brightness_value);
}
void captureEvent(Capture c) {
  c.read();
}