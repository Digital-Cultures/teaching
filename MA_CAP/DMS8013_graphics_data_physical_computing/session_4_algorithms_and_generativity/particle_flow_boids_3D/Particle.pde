/*
PARTICLE CLASS
 MIT License
 Copyright (c) 2016 Tom Schofield
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */
class Particle {
  PVector pos;
  float x, y, z;
  float speedX, speedY, speedZ;
  PVector speed;
  int rad =(int)random(5, 14);
  int index;
  int threshold  = rad*4;
  color col;
  Particle(float _x, float _y, float _z, float _speedX, float _speedY, float _speedZ, int _index) {
    x = _x;
    y  =_y;
    z = _z;
    speedX = _speedX;
    speedY = _speedY;
    speedZ = _speedZ;
    speed = new PVector(speedX, speedY, speedZ);

    index = _index;
    colorMode(HSB, 100);
    col = color(random(100), 100, 100);
    colorMode(RGB, 255);
    pos = new PVector (x, y, z);
  }

  void update(Particle [] otherParticles) {

    //update the postiion by adding the speed
    pos.x+=speed.x;
    pos.y+=speed.y;
    pos.z+=speed.z;


    for (int i=0; i<otherParticles.length; i++) {
      if (i!=index) {

        //   println(i, index, otherParticles[i].speed.dist(speed));
        // if (    dist(otherParticles[i].x, otherParticles[i].y, x, y) > threshold-1 && dist(otherParticles[i].x, otherParticles[i].y, x, y) < threshold+1 ) {


        if ( otherParticles[i].pos.dist(pos)  < threshold+1) {
          //take the speed of this other close particle with a bit
          ///of randomness
          // println("change");
          //replace by finding the central path

          speed.x = (otherParticles[i].speed.x  +speed.x)/2   +random(-0.5, 0.5);
          speed.y = (otherParticles[i].speed.y + speed.y)/2+random(-0.5, 0.5);

          speed.z = (otherParticles[i].speed.z+ speed.z)/2+ random(-0.5, 0.5);
          // rad+=4;
          threshold  = rad*2;
        }
      }
    }
    if (pos.x>=width|| pos.x <= 0 ) {

      speed.x*=-1;
    }
    if ( pos.y >= height ||pos.y <= 0) {
      speed.y*=-1;
    }
    if ( pos.z >= height || pos.z <= -height) {
      speed.z*=-1;
    }


    //annealing -  lets gradually shrink the particle
    if (speed.x>5) {
      speed.x*=0.99;
    }
    if (speed.y>5) {
      speed.y*=0.99;
    }
    if (speed.z>5) {
      speed.z*=0.99;
    }
    //if it gets too big then pop it!
    if (rad>100) {
      rad  =2;
    }
  }
  void display() {
    fill(col);
    noStroke();
    pushMatrix();
    // ellipse( x, y, rad, rad);
    translate(pos.x, pos.y, pos.z);
    sphere(rad);
    popMatrix();
  }
}

