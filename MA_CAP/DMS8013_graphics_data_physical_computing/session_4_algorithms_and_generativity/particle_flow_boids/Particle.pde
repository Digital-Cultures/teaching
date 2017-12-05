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
  float x, y;
  float speedX, speedY;
  int rad =(int)random(5,14);
  int index;
  int threshold  = rad*2;
  color col;
  Particle(float _x, float _y, float _speedX, float _speedY, int _index) {
    x = _x;
    y  =_y;
    speedX = _speedX;
    speedY = _speedY;

    index = _index;
    colorMode(HSB, 100);
    col = color(random(100), 100, 100);
    colorMode(RGB, 255);
  }

  void update(Particle [] otherParticles) {

    //update the postiion by adding the speed
    x+=speedX;
    y+=speedY;

    for (int i=0; i<otherParticles.length; i++) {
      if (i!=index){
        if ( dist(otherParticles[i].x, otherParticles[i].y, x, y) > threshold-1 && dist(otherParticles[i].x, otherParticles[i].y, x, y) < threshold+1 ) {
        
          //take the speed of this other close particle with a bit
          ///of randomness
          speedX = otherParticles[i].speedX+random(-0.5,0.5);
        speedY = otherParticles[i].speedY+random(-0.5,0.5);
        // rad+=4;
        threshold  = rad*2;
      }
    }
  }
  if (x>=width|| x <= 0 ) {

    speedX*=-1;
  }
  if ( y >= height || y <= 0) {
    speedY*=-1;
  }
  //annealing -  lets gradually shrink the particle
  if (speedX>5) {
    speedX*=0.99;
  }
  if (speedY>5) {
    speedY*=0.99;
  }
  //if it gets too big then pop it!
  if (rad>100) {
    rad  =2;
  }
}
void display() {
  fill(col);
  ellipse( x, y, rad, rad);
}
}
