//A list of images
PImage [] images;
//how many images do we want
int numImages = 360;
//which image shall we display this frame?
int counter = 0;
//how fast should we update the frame?
int rate = 120;

void setup() {
  //set the size of the screen
  size(640, 640);
  
  //lets createe our list of images properly (And decide how many there are)
  images = new PImage[numImages];
  
  ///where shall we centre our map?
  String lat = "45.343851";
  String lon = "36.68512";

  //for each image
  for (int i=0; i<numImages; i++) {
    //load the image from file 
   // images[i] = loadImage( str(i)+".jpg" );
    //(or from the web if you want to grab new ones - uncomment to try
    String url = "https://maps.googleapis.com/maps/api/streetview?size=640x640&location="+lat+","+lon+"&heading="+str(i)+".78&pitch=-0.76";
    images[i] = loadImage( url, "jpg");  
    println(url);
    
    //lets make a filename
    String fname = str(i)+".jpg";
    //and save it so we don't have to grab it from the web next time
    //images[i].save(savePath(fname));
  }
}


void draw() {
  //show the current image
  image(images[counter],0,0);
  
  //increment the counter by one
  counter++;
  //reset the counter to the beginning
  if(counter>=numImages){
   counter=0; 
  }
  

}
void keyPressed(){
 if(key=='q'){
   rate+=5;
 }
 else if (key=='a'){
   rate-=5;
 }
 frameRate(rate);
 println(frameRate);
}