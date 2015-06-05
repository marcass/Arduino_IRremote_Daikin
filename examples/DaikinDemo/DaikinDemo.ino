
/*
 * 
 * 
 * Version 0.0.1 Aug, 2014
 * Copyright 2014 danny
 * https://github.com/danny-source/Arduino_IRremote_Daikin
 */

#include "IRdaikin.h"


IRdaikin irdaikin;
int isOn;

void setup()
{
  Serial.begin(9600);
 irdaikin.daikin_on();
 irdaikin.daikin_setSwing_off();
 irdaikin.daikin_setMode(1); // Mode set to heat
 irdaikin.daikin_setFan(1);//FAN speed to MIN
 irdaikin.daikin_setTemp(25);
 //----everything is ok and to execute send command-----
 irdaikin.daikin_sendCommand();
 isOn = 0;
}

void loop() {
  while (Serial.available() > 0) {

    if (Serial.read() == '\n') {
        if (isOn == 0){
          isOn = 1;
          irdaikin.daikin_off();
          Serial.println("Turn Off");
        }else{
          isOn = 0;
          irdaikin.daikin_on();
          Serial.println("Turn On");
        }
        irdaikin.daikin_sendCommand();
        Serial.println("Execute Command!");
    }
  }
}
