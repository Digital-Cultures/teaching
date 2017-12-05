
//make an ARRAY of raindrops. An array is a list or set
Raindrop [] drops;


void setup(){
  size(800,600);
  
  
  //here I'm telling the computer that I want 45 raindrops in my list
  drops = new Raindrop[45];
  
  //from zero to as many drops (drops.length) as I have i.e. 40
  for(int i=0;i<drops.length;i++){
    //make a new raindrop to fill up the list
   drops[i] = new Raindrop(i); 
  }
  
}


void draw(){
  background(0);
  for(int i=0;i<drops.length;i++){
   drops[i].checkOtherDrops(drops);
   drops[i].move();
   drops[i].display();
  }
  
  
}