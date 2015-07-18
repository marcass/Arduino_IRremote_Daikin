
/*
 * 
 * 
 * Version 0.0.1 Aug, 2014
 * Copyright 2014 danny
 * https://github.com/danny-source/Arduino_IRremote_Daikin
 */

#include "IRdaikin.h"


IRdaikin irdaikin;

void setup()
{ 
 pinMode(3, OUTPUT);
 digitalWrite(3, LOW);
 pinMode(2, INPUT);
 digitalWrite(2, LOW);
 pinMode(8, INPUT);
 digitalWrite(8, LOW);
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
   digitalWrite(8, LOW);
}


// constants won't change. They're used here to set pin numbers:
const int PinOn = 2;     // the number of the pin for on
const int PinOff = 8;     // the number of the pin for off
const int ledPin =  13;      // the number of the LED pin

// variables will change:
int OnState = 0;         // variable for reading the pin status
int OffState = 1;         // variable for reading the pin status

void loop(){
  // read the state of the input pin value:
  OnState = digitalRead(PinOn);
  OffState = digitalRead(PinOff);

  // check if the pin is brought to high.
  // if it is, the OnState|OffState is HIGH:
  if (OnState == HIGH && OffState == LOW) {
    // send IR signal for on:
    turn_on();
//    delay(1000);
  }
  else if (OffState == HIGH && OnState == LOW) {
    // send IR signal for off:
    turn_off();
  }
  else {
    // do nothing:
    
  }
}

