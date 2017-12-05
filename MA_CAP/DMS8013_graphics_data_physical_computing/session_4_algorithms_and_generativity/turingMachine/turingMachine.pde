/*
TURING MACHINE SIMULATOR
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

///follows machine descriptions at http://rosettacode.org/wiki/Universal_Turing_machine as a Three-state busy beaver


//here we've got a list of booleans (yes/no) 
boolean tape [];
int w;
int borderSize;
int headIndex;

//here we're setting the original state of the machine to 'a'
String headState = "a";

void setup() {
  
  size(800, 100);
  frameRate(25);
  borderSize = 50;
  
  
  tape = new boolean[100];
  headIndex = (int) random(tape.length);
  w = (width - (2*borderSize))/tape.length;
  fillTapeEmpty();
}

void draw() {
  background(120);
  drawHead(50);
  drawTape(w, 7, borderSize, 58);
  rule();
}

///
void fillTapeEmpty() {
  ///for loop - go through the whole tape and set all the positions to false
  for (int i=0; i<tape.length; i++) {
      tape[i] = false;
  }
}
void drawHead(int y) {
  if (headState.equals("a")) {
    fill(255, 0, 0);
  } else if (headState.equals("b")) { 
    fill(0, 255, 0);
  } else if (headState.equals("c")) { 
    fill(0, 255, 255);
  } else if (headState.equals("halt")) { 
    fill(0, 255, 255);
  }

  int xPos = borderSize + (headIndex * w);
  rect(xPos, y, w, 8);
}


void rule() {

  if (headState.equals("a") && !tape[headIndex]) {
    tape[headIndex] = true; 
    headState = "b";
    headIndex++;
  } else if (headState.equals("a") && tape[headIndex] ) {
    tape[headIndex] = true; 
    headState = "c";
    headIndex--;
  } 
   else if (headState.equals("b") && !tape[headIndex] ) {
    tape[headIndex] = true; 
    headState = "a";
    headIndex--;
  } 
   else if (headState.equals("b") && tape[headIndex] ) {
    tape[headIndex] = true; 
    headState = "b";
    headIndex++;
  } 
   else if (headState.equals("c") && !tape[headIndex] ) {
    tape[headIndex] = true; 
    headState = "b";
    headIndex--;
  } 
   else if (headState.equals("c") && tape[headIndex] ) {
    tape[headIndex] = false; 
    headState = "c";
    headIndex ++;
    //headIndex--;
  } 










  if (headIndex <0) {
    headIndex = tape.length-1;
  } else if (headIndex >=tape.length ) {
    headIndex = 0;
  }
}

void drawTape(int cellWidth, int cellHeight, int x, int y) {
  pushMatrix();
  translate(x, y);
  for (int i=0; i<tape.length; i++) {

    if (tape[i]) {
      fill(0);
    } else {
      fill(255);
    }
    rect(i*cellWidth, 0, cellWidth, cellHeight);
  }
  popMatrix();
}

