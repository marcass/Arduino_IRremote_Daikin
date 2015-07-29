
## Heatpump control using library from Danny

Uses MQTT to communicate with OpenHab (prviding a web, android and iOS client). Requrires and arduino for sending the ir signal (to get timing for signal transmission) and an ESP8266 module for communication. I'm using version 12 of the ESP module due to the greater number of IO pins.

ESP modules running NodeMCU with code that is inelegant due to my pitiful attemps to concerve memory in the code.
 Comms go client-->internet-->openhab-->internet-->esp module-->arduino. Due to heatpump silliness the state of the heatpump cannot easily be determined. Buy a heatpump that publishes infomration about its state (if you are considering buying one)
 
The esp module also publises temperature so it can be graphed in the OpenHab client

I can control some daikin heatpumps with Danny's modified code with some finesse. The panasonic heatpump I have to control using raw codes harvested from the remote.

## IRdaikin

 IRdaikin

 Version:0.0.3

 Sep, 2014

 Copyright 2014 danny

 IRremote library base from Ken Shirriff's IRremote library and add daikin IR function.
 IRdaikin is using custom IRremote library to simply to send daikin air conditioning ir command.

 ![](https://github.com/marcass/Arduino_IRremote_Daikin/blob/master/circuit.jpg)

## Pinout:

  - pin 3:nano (to IR led)
  


## Setting function:

Set perfererd default settings in the approprirate arduiino sketch

- daikin_on();//turn on
- daikin_off();//turn off
- daikin_setSwing_on();//turn on swing
- daikin_setSwing_off();//turn off swing
- daikin_setMode(int mode);//0=FAN, 1=HEAT, 2=DRY
- daikin_setFan(int speed);// 0~4=speed(1,2,3,4,5),5=auto,6=moon
- daikin_setTemp(int temp);//18 ~ 32 Celsius,if you using Fahrenheit ,maybe to enter Fahrenheit.
- daikin_sendCommand();

 ## Execute function:

- daikin_sendCommand();

  You must initial setting by your programming and,
  After Setting execute daikin_sendCommand()

## Example:

```
 daikin_on();
 daikin_setSwing_off();
 daikin_setMode(1)
 daikin_setFan(4);//FAN speed to MAX
 daikin_setTemp(25);
 //----everything is ok and to execute send command-----
 daikin_sendCommand();
```
