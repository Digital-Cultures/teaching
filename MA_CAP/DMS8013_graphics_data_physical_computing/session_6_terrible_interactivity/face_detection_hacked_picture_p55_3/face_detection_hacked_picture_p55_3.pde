import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

PImage orange;


// contrast/brightness values
int contrast_value    = 0;
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


//public void stop() {
//  opencv.stop();
//  super.stop();
//}



void draw() {

  // grab a new frame
  // and convert to gray
  opencv.loadImage(video);
 // opencv.convert( GRAY );
  //opencv.contrast( contrast_value );
  //opencv.brightness( brightness_value );

  // proceed detection
  Rectangle[] faces = opencv.detect( );//1.2, 2, OpenCV.HAAR_DO_CANNY_PRUNING, 40, 40 );

  // display the image
  image( video, 0, 0 );

  // draw face area(s)
  noFill();
  stroke(255, 0, 0);
  println(faces.length);
  for ( int i=0; i<faces.length; i++ ) {
    //rect( faces[i].x, faces[i].y, faces[i].width, faces[i].height );
    image(orange,faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
  loadPixels();


}



/**
 * Changes contrast/brigthness values
 */
void mouseDragged() {
  contrast_value   = (int) map( mouseX, 0, width, -128, 128 );
  brightness_value = (int) map( mouseY, 0, width, -128, 128 );
}
void captureEvent(Capture c) {
  c.read();
}