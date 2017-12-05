class Planet {
  //each planet has it's own rotation speed
  float rot;
  int distanceFromSun;
  int dia;
  int numSatellites;
  int [] satSizes;
  int [] satDistances;
  color [] satColours;
  color col;
  float rotSpeed;
  
  Planet(int _distanceFromSun, int _dia, int _numSatellites, color _col, int [] _satSizes, int [] _satDistances, color [] _satColours) {
    //randomly set the speed in the construtor
    rotSpeed = random(0.005, 0.02);
    
    //pass in all these values from the constructor
    distanceFromSun = _distanceFromSun;
    dia = _dia;
    numSatellites = _numSatellites;
    col = _col;
    satSizes = _satSizes;
    satDistances = _satDistances;
    satColours = _satColours;
  }

  void drawPlanet() {
    
    //we don't want the changes we make here to affect any thing outside this class so lets save the matrix state and also all the style decisions
    pushStyle();
    pushMatrix();
    fill(col);
    rotateY(rot);
    translate(distanceFromSun, 0);
    //draw the sun
    sphere(dia);
    
    //draw the satellites
    for (int i=0; i<numSatellites; i++) {
      pushMatrix();
      fill(satColours[i]);
      //a rather crude way of spacing
      rotateY(rot * i *0.5);
      translate(satDistances[i], 0);
      sphere(satSizes[i]);
      popMatrix();
    }


    popMatrix();
    popStyle();
    
    //increment the rotation angle
    rot +=rotSpeed;
  }
}