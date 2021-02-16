#include <SoftwareSerial.h>

// If you have noisy inputs it can sometimes help to take a
// few readings and then work out their average
// This works particularly well if you have tightly spaced
// resistor ladders
// Using this method I have successfully managed to obtain
// reliable readings from 36 buttons on a single analog pin
// Theoretically it is possible to hang 216 from an UNO but
// I am yet to try it due to a lack of that many 3.3k Ohm
// resistors
// Pete Haughie MA - ;)

#define apin A0

// consider changing this number to see if you can get
// any interesting effects
// a larger value may take much longer to change over time
// but will be more 'smooth' whilst a lower value will be
// more likely to differ more between mean calculations and 
// fluctuate the output
const int readings_count = 10;

// create an array of the size specified by readings_count
int readings[readings_iterator] = {};

// just some variable for value storage later
int readings_sum;
int readings_mean;
int reading_index = 0;

void setup() {
  pinMode(apin, INPUT);

  // if you don't fill the array up during setup
  // you'll notice a 'ramp' as the sum increases
  // from 0 for ten ticks and the mean value increases
  // correspondingly - much like a digital capacitor!
  // This process takes around 130ms so you most likely
  // won't notice it in your project start-up time
  // You may find it interesting to
  // attach an array of LEDs which light and dim
  // when thresholds are matched and passed,
  // in conjunction with PD and serial comms,
  // or with a floating pin and a microcontroller
  // based noise making maching such as Audunio or
  // ArduinoSynth.
  // Have a play!

  for (int i = 0; i < readings_iterator; i++) {
    readings[i] = (analogRead(apin));
    readings_sum = readings_sum + readings[i];
  }

}

void loop() {

  // every tick of the duty cycle we increase the
  // readings_index by 1 so that we're gradually
  // rather than asking the board to fill all ten
  // values at the same time - whilst quick it
  // will introduce perceptable 'flicker' to
  // any attached LEDs as the CPU concentrates
  // on this one task - remember the ATMega
  // only has a single core 

  if (reading_index < readings_count) {
    reading_index += 1;
  } else {
    reading_index = 0;
  }

  // read the new value and store it in our 
  readings[readings_index] = (analogRead(apin));

  // take our readings and produce the sum by
  // dividing it by the number of iterations we
  // set in our global variable 'readings_count'
  readings_mean = readings_sum / readings_count;
  
  // print our value to the serial monitor
  Serial.println(reading_mean);

  // introducing a pause increases board reliability
  delay(10);
}
