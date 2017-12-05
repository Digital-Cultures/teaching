const int bufferSize = 200;
int myBuffer [bufferSize];
int bufferIndex = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  ///fill up the buffer with zeros at each position
  for (int i = 0; i < bufferSize; i++) {
    myBuffer[i] = 0;
  }
}

void loop() {
  // put your main code here, to run repeatedly:
  int reading = analogRead(A0);
  ///put the most recent reading in the array at position bufferIndex
  myBuffer[bufferIndex] = reading;

  float total = 0;
  //go through each position in the buffer and add what's there to total
  for (int i = 0; i < bufferSize; i++) {
    total += myBuffer[i];
  }
  //get the mean by dividing the total by the buffer size
  float smoothedReading = total / bufferSize;

  Serial.print("A");
  Serial.println((int)smoothedReading);
  Serial.print("B");
  Serial.println(reading);

  bufferIndex++;
  if (bufferIndex >= bufferSize) {
    bufferIndex = 0;
  }
}
