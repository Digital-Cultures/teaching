class Raindrop {
  float x;
  float y;
  float speed;
  float rad;
  color col;
  
  //i've added an index, and ID so that we know where this drop is in the list
  int index;
  //this is a constructor - it's like setup but for an object - see I'm PASSING the index in from outside
  Raindrop(int _index) {
    y = 0;
    //set the x position as a random number between zero and the screen width
    x = random(width);
    
    //I've added a variable for the radius to make things neater
    rad = 5;
    speed = random(2, 5);
    //starting with a random color
    col = color( random(255), random(255), random(255));
    index = _index;
  }

  //this function is taking a list of raindrops as an argument/parameter
  void checkOtherDrops(Raindrop [] otherDrops) {
    
    //go through all the other drops
    for (int i=0; i<otherDrops.length; i++) {
      
      //this looks complicated but it's checking whether this particular other drop overlaps with me
      if (otherDrops[i].x >= x-rad && otherDrops[i].x<= x+rad && otherDrops[i].y>=y-rad && otherDrops[i].y<=y+rad) {
        
        //I need to make sure that I'm not comparing the same two drops
        if ( i!=index) {
          //here's where the magic happens. In this example I'm randomising the color when the drops overlap
          col = color( random(255), random(255), random(255));
        }
      }
    }
  }

  void move() {
    //increase (increment) the y position by the speed each time
    y+=speed;
    //if y gets bigger than the height make y zero again (cycle repeats)
    if (y>=height) {
      y=0;
      x = random(width);
    }
  }

  void display() {
    
    //because the color is now in a variable each drop has its own
    fill(col);
    ellipse(x, y, 2*rad, 2*rad);
  }
}