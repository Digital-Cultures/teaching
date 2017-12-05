//Stupid button Tom Schofield 2017

// constants won't change. They're used here to
// set pin numbers:
 int buttonPin = 2;     // the number of the pushbutton pin
const int ledPin =  13;      // the number of the LED pin

// variables will change:
int buttonState = 0;         // variable for reading the pushbutton status
int interval = 100;
int points = 0;
boolean lightUp = true;
int frameCount = 0;
void setup() {
  // initialize the LED pin as an output:
  pinMode(ledPin, OUTPUT);
  // initialize the pushbutton pin as an input:
  pinMode(buttonPin, INPUT);
  Serial.begin(9600);
}

void loop() {
  // read the state of the pushbutton value:
  buttonState = digitalRead(buttonPin);
  if(buttonPin>=10){
    digitalWrite(11, HIGH);
  }
  if(points>5){
    digitalWrite(12, HIGH);
  }
  // check if the pushbutton is pressed.
  // if it is, the buttonState is HIGH:
  if (buttonState == HIGH) {
    // turn LED on:
    if (lightUp) {
      digitalWrite(ledPin, HIGH);
      points ++;
    } else {
      // turn LED off:
      digitalWrite(ledPin, LOW);
      buttonPin++;
      Serial.println(buttonPin);
      
    }
  } else {
    // turn LED off:
    digitalWrite(ledPin, LOW);
  }

  frameCount++;
  //Serial.println(frameCount);
  if (frameCount > interval) {

    lightUp = !lightUp;
    frameCount = 0;
  }
}
