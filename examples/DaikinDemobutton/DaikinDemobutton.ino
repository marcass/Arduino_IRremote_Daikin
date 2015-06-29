
/*
 * 
 * 
 * Version 0.0.1 Aug, 2014
 * Copyright 2014 danny
 * https://github.com/danny-source/Arduino_IRremote_Daikin
 */

#include "IRdaikin.h"


IRdaikin irdaikin;


// constants won't change. They're used here to
// set pin numbers:
const int buttonPinOn = 2;     // the number of the pushbutton pin for on
const int buttonPinOff = 8;     // the number of the pushbutton pin for off
const int ledPin =  13;      // the number of the LED pin

// variables will change:
int buttonOnState = 0;         // variable for reading the pushbutton status
int buttonOffState = 1;         // variable for reading the pushbutton status

void setup() {
  // initialize the LED pin as an output:
  pinMode(3, OUTPUT);      
  // initialize the pushbutton pin as an input:
  pinMode(buttonPinOn, INPUT); 
  digitalWrite(buttonPinOn, LOW);  
  pinMode(buttonPinOff, INPUT);
  digitalWrite(buttonPinOff, LOW);
}

void turn_on()
{
   irdaikin.daikin_on();
   irdaikin.daikin_setSwing_off();
   irdaikin.daikin_setMode(1); // Mode set to heat
   irdaikin.daikin_setFan(1);//FAN speed to MIN
   irdaikin.daikin_setTemp(25);
   //----everything is ok and to execute send command-----
   irdaikin.daikin_sendCommand();
//   detachInterrupt(0);
   digitalWrite(2, LOW);
}

void turn_off()
{
   irdaikin.daikin_off();
   irdaikin.daikin_setSwing_off();
   irdaikin.daikin_setMode(1); // Mode set to heat
   irdaikin.daikin_setFan(1);//FAN speed to MIN
   irdaikin.daikin_setTemp(25);
   //----everything is ok and to execute send command-----
   irdaikin.daikin_sendCommand();
/*   
   pinMode(13, OUTPUT);
   digitalWrite(13, HIGH);
   delay(4000);
   digitalWrite(13, LOW);
*/
   digitalWrite(8, LOW);
}

void loop(){
  // read the state of the pushbutton value:
  buttonOnState = digitalRead(buttonPinOn);
  buttonOffState = digitalRead(buttonPinOff);

  // check if the pushbutton is pressed.
  // if it is, the buttonState is HIGH:
  if (buttonOnState == HIGH && buttonOffState == LOW) {    
    // send IR signal for on: 
    turn_on();   
    digitalWrite(ledPin, HIGH);
    delay(2000);
    digitalWrite(ledPin, LOW); 
  }
  else if (buttonOffState == HIGH && buttonOnState == LOW) {    
    // send IR signal for off: 
    turn_off();   
    digitalWrite(ledPin, HIGH);
    delay(1000);
    digitalWrite(ledPin, LOW);
    delay(1000);
    digitalWrite(ledPin, HIGH);
    delay(1000);
    digitalWrite(ledPin, LOW);
  }
  else {
    // turn LED off:
    digitalWrite(ledPin, LOW);
  }
}
