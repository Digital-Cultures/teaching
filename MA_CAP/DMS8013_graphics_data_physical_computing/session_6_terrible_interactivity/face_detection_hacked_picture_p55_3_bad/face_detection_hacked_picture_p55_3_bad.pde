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
  //  for (int i=0; i<faces.length; i++) {
  //    image(orange, faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  //  }
  //}
  switchFaces(faces, cvimage);

  //draw debugging text to the screen
  fill(255, 0, 0);
  text("Contrast: "+contrast_value +" \nBrightness: "+ brightness_value, 50, 50);
  loadPixels();
}

void switchFaces(Rectangle[] faces, PImage cvimage) {
  ArrayList faceCutOuts = new ArrayList();

  if (faces.length > 0) {
    for (int i=0; i<faces.length; i++) {
      PImage cutout = cvimage.get(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
      faceCutOuts.add(cutout);
    }
    //get cutouts of all the faces and reverse their order ina list
    PImage [] sorted = new PImage [faceCutOuts.size()];
    for (int i=0; i<faceCutOuts.size(); i++) {
      sorted[i] = (PImage) faceCutOuts.get(faceCutOuts.size()-(i+1));
      image(sorted[i], faces[i].x, faces[i].y);
    }
  }
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