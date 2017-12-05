/*
GREEDY PARTICLES
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
//declare an array of particle objects
Particle [] particles;

void setup(){
  size(892,508, P3D);
  
  //lets start with 100 of them
  particles = new Particle [100];
  
  ///lets run through each of the empty spaces in our array of particles and put a particle there
  for(int i=0;i<particles.length;i++){
    float x = random(width);
    float y = random(height);
    float z = random(height);
    
    float sx = random(1,4);
    float sy = random(1,4);
    float sz = random(1,4);
    
    particles[i] = new Particle (x,y,z, sx,sy,sz,i);
  }
  
}

void draw(){
  background(0);
  directionalLight(mouseX, mouseY, 126, 0, 0, -1);
  pointLight(51, 102, 126, 35, 40, 36);
  //for each particle update it and draw it
  for(int i=0;i<particles.length;i++){
    
    //we pass the list of particles in because each one needs to know where all the other are
    particles[i].update(particles);
    particles[i].display();
  }
  
}