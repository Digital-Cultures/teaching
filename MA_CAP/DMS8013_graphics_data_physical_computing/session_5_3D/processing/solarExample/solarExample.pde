float rot = 0;
void setup() {
  size(1200, 600, P3D);
}

void draw() {
  background(0);
  
  //setup some lights and link to mouse
  pointLight(255, 255, 255, mouseX, mouseY, 0);
  
  //without the ambient light we get very harsh shadows
  ambientLight(102, 102, 102);

  //color the sun red
  fill(255, 0, 0);
  //I want to see the lines so I can check it's spinning
  stroke(0);
  //shift matrix to centre
  translate(width/2, height/2, 0);

  //save this matrix position
  pushMatrix();
  //rotate the sun
  rotateY(rot);
  sphere(80);
  noStroke();
  //move the matrix out a bit and then we'll draw a planet there
  translate(200, 0, 0 );
  sphere(10);
  popMatrix();
  //rotate planet 2 but this time twice as fast
  pushMatrix();
  rotateY(rot*2);
  fill(0, 255, 0);
  noStroke();
  translate(200, 0, 0 );
  sphere(10);
  popMatrix();
  
  //increment our rotation variable
  rot += 0.02;
}