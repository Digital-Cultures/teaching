int inPin = A0;
int pReading = 0;
int ledPin = 6;    // LED connected to digital pin 9


void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  int reading = analogRead(inPin);
  int speed = abs(reading - pReading);
  Serial.println(speed);
  int fadeValue = speed;
  analogWrite(ledPin, fadeValue);
  pReading = reading;

}
