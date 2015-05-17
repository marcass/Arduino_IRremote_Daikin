/*
 * IRdaikin
 * Version 0.0.2 Sep, 2014
 * Copyright 2014 danny
 *
 *IRremote library base from Ken Shirriff's IRremote library and add daikin IR function.
 *IRdaikin is using custom IRremote library to simply to send daikin air conditioning ir command.
 *
 *0.Pinout:
 * pin 3:UNO
 * pin 2:Leonardo
 * pin 9:Mega
 *
 *1.Setting:
 *
 *daikin_on();
 *daikin_off();
 *daikin_setSwing_on();
 *daikin_setSwing_off();
 *daikin_setMode(int mode);//0=FAN, 1=COOL, 2=DRY
 *daikin_setFan(int speed);// 0~4=speed(1,2,3,4,5),5=auto,6=moon
 *daikin_setTemp(int temp);//18 ~ 32 Celsius,if you using Fahrenheit ,maybe to enter Fahrenheit.
 *daikin_sendCommand();
 *
 *2.Execute:
 *daikin_sendCommand();
 *
 * You must initial setting by your programming and,
 * After Setting execute daikin_sendCommand()
 *
 *Example:
 *
 *daikin_on();
 *daikin_setSwing_off();
 *daikin_setMode(1)
 *daikin_setFan(4);//FAN speed to MAX
 *daikin_setTemp(25);
 *----everything is ok and to execute send command-----
 *daikin_sendCommand();
 */

#include "IRdaikin.h"


// # of bytes per command
const int COMMAND_LENGTH = 27;    

unsigned char daikin[COMMAND_LENGTH]     = { 
0x11,0xDA,0x27,0xF0,0x00,0x00,0x00,0x20,
//0    1    2   3    4    5     6   7
0x11,0xDA,0x27,0x00,0x00,0x41,0x1E,0x00,
//8    9   10   11   12    13   14   15
0xB0,0x00,0x00,0x00,0x00,0x00,0x00,0xC0,0x00,0x00,0xE3 };
//16  17    18  19   20    21   22  23   24   25   26

static byte vFanTable[] = { 0x30,0x40,0x50,0x60,0x70,0xa0,0xb0};
//0 FAN 1 COOL 2 DRY
static byte vModeTable[] = { 0x6,0x3,0x2};
//
// void IRdaikin()
// {
// 	daikinController_off();
// 	daikinController_setMode(0);
// 	daikinController_setTemp(26);
// 	daikinController_setFan(5);
// 	daikin_setSwing_off();
// }
IRsend irsend;

void IRdaikin::daikin_on()
{
	daikinController_on();
}  

void IRdaikin::daikin_off()
{
	daikinController_off();
}

void IRdaikin::daikin_setSwing_on()
{
	daikin[16] |=0x0f;
	daikinController_checksum();
}

void IRdaikin::daikin_setSwing_off()
{
	daikin[16] &=0xf0;
	daikinController_checksum();
}

void IRdaikin::daikin_setMode(int mode)
{
	if (mode>=0 && mode <=2)
	{
		daikinController_setMode(vModeTable[mode]);		
	}
}

// 0~4 speed,5 auto,6 moon
void IRdaikin::daikin_setFan(int speed)
{
	if (speed>=0 && speed <=6)
	{
		daikinController_setFan(vFanTable[speed]);
	}
}

void IRdaikin::daikin_setTemp(int temp)
{
	if (temp >= 18 && temp<=32)
	{
		daikin[14] = (temp)*2;
		daikinController_checksum();
	}
}

void IRdaikin::daikin_sendCommand()
{
		sendDaikinCommand();
}
//
uint8_t IRdaikin::daikinController_checksum()
{
	uint8_t sum = 0;
	uint8_t i;


	for(i = 0; i <= 6; i++){
		sum += daikin[i];
	}

        daikin[7] = sum &0xFF;
        
        sum=0;
	for(i = 8; i <= 25; i++){
		sum += daikin[i];
        }

        daikin[26] = sum &0xFF;

        
}


//private function

void IRdaikin::daikinController_on()
{
	daikin[13] |= 0x01;
	daikinController_checksum();
}

void IRdaikin::daikinController_off()
{
	daikin[13] &= 0xFE;
	daikinController_checksum();
}

void IRdaikin::daikinController_setTemp(uint8_t temp)
{
	daikin[14] = (temp)*2;
	daikinController_checksum();
}


void IRdaikin::daikinController_setFan(uint8_t fan)
{
	daikin[16] &= 0x0f;
	daikin[16] |= fan;
	daikinController_checksum();
}

uint8_t IRdaikin::daikinController_getState()
{
	return (daikin[13])&0x01;
}

void IRdaikin::daikinController_setMode(uint8_t mode)
{
	daikin[13]=mode<<4 | daikinController_getState();
	daikinController_checksum();
}

void IRdaikin::sendDaikinCommand()
{
      daikinController_checksum();  
      irsend.sendDaikin(daikin, 8,0); 
      delay(29);
      irsend.sendDaikin(daikin, 19,8); 
}
