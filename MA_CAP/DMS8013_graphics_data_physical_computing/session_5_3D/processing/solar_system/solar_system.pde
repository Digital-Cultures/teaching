Planet [] planets;
int numPlanets = 10;
float sunRot = 0;
void setup() {
  size(1920, 1080, P3D);
  planets  = new Planet [numPlanets];

  for (int i=0; i<planets.length; i++) {
    int dia = (int) random(8,30);
    int numSatellites = (int) random (1, 6);
    int [] satSizes = new int [numSatellites];
    int [] satDistances = new int [numSatellites];
    color [] satColours = new color [numSatellites];
    
    for(int j=0;j<numSatellites;j++){
      satSizes[j] = (int) random (4,7);
      satDistances[j] = dia+(j * (int) random (10,15));
      satColours[j] = color(random(255),random(255),random(255)); 
    }
    
    
    planets[i] = new Planet((1+i) * (int) random(100,150), dia, numSatellites,  color(random(255),random(255),random(255)) , satSizes, satDistances, satColours) ;
  }
}


void draw() {
  background(0);
  //control the x position of the point light with the mouse
  pointLight(255, 255, 255, mouseX, 0, 0);
  ambientLight(102, 102, 102);
  
  //make the origin point of the matrix the middle of the screen
  translate(width/2, height/2);
  //rotate everything that follows around the x axis (controlled by the mouse)
  rotateX(mouseY*0.01);
  //we only want the Y rotation to affect the sun so save the matrix position
  pushMatrix();
  
  rotateY(sunRot);
  fill(255, 255, 20);
  stroke(255, 255, 0);
  sphere(80);
  //return to the un-rotated state
  popMatrix();
  
  noStroke();
  //go through all of our planet objects and draw them
  for(int i=0;i<planets.length;i++){
   planets[i].drawPlanet();
  }
  sunRot+=0.002;
}