/* Send raw panasonic signal to heatpump to emulate
 * Panasonic remote number A75C2317
 * An IR LED must be connected to Arduino PWM pin 3.
 * Version 0.1 July, 2009
 * Code borrowed from "Copyright 2009 Ken Shirriff"
 * http://arcfn.com
  * Altered by Marcus
 */

#include <IRremote.h>

IRsend irsend;

// Listen on serial
void setup()
{
  Serial.begin(9600);
  //IR Demo send a cmd to panasonic heatpump
 Serial.println("IR Demo raw send a harvested cmd to Panasonic heatpump");
 Serial.println("Please input any data to the Serial Interface in order to start the Demo");
 Serial.println("");
}


//Send it all
void loop() {
  #define first_push
//  #define second_push
//  #define third_push
//  #define fourth_push


  #ifdef first_push
  unsigned int raw[105] = {3528, 3464, 884, 2604, 888, 856, 896, 844, 900, 2588, 876, 868, 876, 2612, 880, 864, 876, 868, 896, 2592, 872, 868, 880, 864, 872, 2616, 900, 844, 872, 2616, 876, 868, 872, 868, 876, 868, 872, 868, 876, 2616, 872, 868, 876, 868, 872, 868, 876, 868, 872, 868, 876, 868, 872, 868, 892, 2596, 904, 840, 872, 872, 888, 852, 876, 868, 872, 868, 3520, 3464, 900, 2592, 872, 868, 904, 840, 900, 2588, 876, 868, 900, 2588, 876, 868, 872, 868, 876, 2612, 904, 840, 876, 868, 876, 2612, 876, 868, 872, 2616, 876, 868, 872, 868, 876, 864, 876, 868, 900};
  if (Serial.read() != -1) {
        Serial.println("Send raw from first push");
        // altered the code just to send/test my raw code
        irsend.sendRaw(raw,105,40);
        delay(2000);
        Serial.println("Sent.. working?");

    }
  #endif 
  
    #ifdef second_push
    unsigned int raw[69] = {3528, 3464, 900, 2588, 900, 844, 900, 840, 900, 2588, 900, 844, 900, 2588, 900, 844, 900, 840, 900, 2592, 900, 840, 900, 844, 900, 2588, 900, 844, 900, 2588, 900, 844, 900, 840, 900, 844, 900, 840, 900, 2588, 904, 840, 900, 844, 900, 840, 900, 844, 900, 840, 900, 844, 900, 840, 900, 2588, 900, 844, 900, 844, 900, 840, 900, 844, 900, 840, 3520, 3464, 900};
    if (Serial.read() != -1) {
        Serial.println("Send raw from second push");
        // altered the code just to send/test my raw code
        irsend.sendRaw(raw,69,40);
        delay(2000);
        Serial.println("Sent.. working?");

    }
  #endif
  
    #ifdef third_push
  unsigned int raw[531] = {3524, 3488, 876, 2616, 872, 868, 900, 844, 900, 2588, 872, 872, 872, 2616, 876, 868, 900, 840, 876, 2612, 876, 868, 872, 872, 872, 2616, 900, 840, 880, 2612, 872, 868, 876, 868, 876, 864, 876, 868, 872, 2620, 872, 868, 872, 868, 872, 872, 872, 868, 876, 868, 872, 868, 876, 868, 896, 2592, 872, 872, 872, 872, 868, 872, 872, 868, 876, 868, 3496, 3488, 872, 2616, 876, 868, 876, 868, 896, 2592, 872, 868, 876, 2616, 872, 868, 876, 868, 872, 2616, 876, 868, 880, 860, 876, 2616, 872, 868, 876, 2616, 872, 868, 876, 868, 872, 868, 872, 872, 872, 2616, 872, 872, 872, 868, 872, 872, 872, 868, 900, 840, 876, 868, 872, 872, 872, 2616, 872, 868, 876, 868, 884, 856, 900, 844, 872, 872, 3492, 3488, 876, 2616, 872, 872, 872, 868, 872, 2616, 876, 868, 872, 2616, 900, 844, 900, 840, 900, 2592, 900, 844, 868, 872, 872, 2616, 876, 868, 872, 2616, 876, 868, 896, 844, 876, 868, 872, 868, 880, 2612, 872, 868, 872, 868, 888, 856, 872, 872, 872, 868, 872, 872, 872, 868, 876, 2612, 876, 868, 872, 872, 872, 868, 876, 868, 872, 868, 3520, 3464, 900, 2588, 876, 868, 892, 852, 872, 2616, 872, 872, 872, 2616, 876, 868, 896, 844, 872, 2616, 876, 868, 900, 840, 876, 2616, 872, 872, 872, 2616, 872, 872, 872, 868, 872, 868, 876, 868, 872, 2616, 872, 872, 872, 872, 872, 868, 872, 868, 876, 868, 872, 868, 872, 872, 872, 2616, 872, 872, 872, 868, 876, 868, 872, 868, 872, 872, 3496, 3488, 872, 2616, 876, 868, 872, 868, 876, 2616, 872, 868, 896, 2600, 872, 864, 876, 868, 872, 2616, 872, 872, 872, 868, 872, 2616, 876, 868, 900, 2592, 868, 872, 872, 872, 872, 868, 872, 872, 896, 2592, 872, 872, 872, 868, 872, 872, 896, 844, 900, 840, 900, 844, 876, 864, 904, 2588, 872, 868, 872, 872, 876, 864, 876, 868, 872, 868, 3496, 3488, 876, 2616, 876, 868, 872, 868, 872, 2616, 876, 868, 876, 2616, 872, 868, 872, 868, 876, 2616, 872, 868, 900, 844, 872, 2616, 876, 868, 872, 2616, 900, 844, 896, 844, 872, 872, 872, 868, 872, 2620, 872, 868, 900, 840, 900, 844, 872, 868, 876, 868, 872, 872, 872, 868, 900, 2588, 876, 868, 876, 868, 872, 868, 900, 840, 876, 868, 3492, 3492, 876, 2616, 872, 868, 872, 872, 872, 2616, 872, 872, 872, 2616, 876, 864, 876, 868, 900, 2588, 876, 868, 872, 868, 876, 2616, 872, 868, 880, 2612, 872, 868, 872, 872, 872, 868, 876, 868, 872, 2616, 872, 872, 872, 868, 876, 868, 872, 868, 876, 868, 872, 868, 884, 860, 872, 2616, 872, 872, 872, 868, 872, 868, 876, 868, 872, 872, 3492, 3492, 872, 2616, 876, 868, 872, 896, 844, 2620, 872, 868, 872, 2620, 872, 868, 872, 872, 872, 2616, 872, 872, 872, 872, 868, 2620, 872, 868, 872, 2620, 868, 896, 848, 868, 876, 868, 872, 872, 868, 2620, 872, 872, 868, 872, 872, 868, 872, 872, 872, 896, 848, 868, 876, 868, 868, 2620, 872, 872, 868, 896, 848, 868, 872, 872, 872, 868, 3496, 3488, 876};
  if (Serial.read() != -1) {
        Serial.println("Send raw from third push");
        // altered the code just to send/test my raw code
        irsend.sendRaw(raw,531,40);
        delay(2000);
        Serial.println("Sent.. working?");

    }
  #endif 
 
    #ifdef fourth_push
  unsigned int raw[465] = {3524, 3488, 876, 2616, 872, 868, 900, 844, 900, 2588, 872, 872, 872, 2616, 876, 868, 900, 840, 876, 2612, 876, 868, 872, 872, 872, 2616, 900, 840, 880, 2612, 872, 868, 876, 868, 876, 864, 876, 868, 872, 2620, 872, 868, 872, 868, 872, 872, 872, 868, 876, 868, 872, 868, 876, 868, 896, 2592, 872, 872, 872, 872, 868, 872, 872, 868, 876, 868, 3496, 3488, 872, 2616, 876, 868, 876, 868, 896, 2592, 872, 868, 876, 2616, 872, 868, 876, 868, 872, 2616, 876, 868, 880, 860, 876, 2616, 872, 868, 876, 2616, 872, 868, 876, 868, 872, 868, 872, 872, 872, 2616, 872, 872, 872, 868, 872, 872, 872, 868, 900, 840, 876, 868, 872, 872, 872, 2616, 872, 868, 876, 868, 884, 856, 900, 844, 872, 872, 3492, 3488, 876, 2616, 872, 872, 872, 868, 872, 2616, 876, 868, 872, 2616, 900, 844, 900, 840, 900, 2592, 900, 844, 868, 872, 872, 2616, 876, 868, 872, 2616, 876, 868, 896, 844, 876, 868, 872, 868, 880, 2612, 872, 868, 872, 868, 888, 856, 872, 872, 872, 868, 872, 872, 872, 868, 876, 2612, 876, 868, 872, 872, 872, 868, 876, 868, 872, 868, 3520, 3464, 900, 2588, 876, 868, 892, 852, 872, 2616, 872, 872, 872, 2616, 876, 868, 896, 844, 872, 2616, 876, 868, 900, 840, 876, 2616, 872, 872, 872, 2616, 872, 872, 872, 868, 872, 868, 876, 868, 872, 2616, 872, 872, 872, 872, 872, 868, 872, 868, 876, 868, 872, 868, 872, 872, 872, 2616, 872, 872, 872, 868, 876, 868, 872, 868, 872, 872, 3496, 3488, 872, 2616, 876, 868, 872, 868, 876, 2616, 872, 868, 896, 2600, 872, 864, 876, 868, 872, 2616, 872, 872, 872, 868, 872, 2616, 876, 868, 900, 2592, 868, 872, 872, 872, 872, 868, 872, 872, 896, 2592, 872, 872, 872, 868, 872, 872, 896, 844, 900, 840, 900, 844, 876, 864, 904, 2588, 872, 868, 872, 872, 876, 864, 876, 868, 872, 868, 3496, 3488, 876, 2616, 876, 868, 872, 868, 872, 2616, 876, 868, 876, 2616, 872, 868, 872, 868, 876, 2616, 872, 868, 900, 844, 872, 2616, 876, 868, 872, 2616, 900, 844, 896, 844, 872, 872, 872, 868, 872, 2620, 872, 868, 900, 840, 900, 844, 872, 868, 876, 868, 872, 872, 872, 868, 900, 2588, 876, 868, 876, 868, 872, 868, 900, 840, 876, 868, 3492, 3492, 876, 2616, 872, 868, 872, 872, 872, 2616, 872, 872, 872, 2616, 876, 864, 876, 868, 900, 2588, 876, 868, 872, 868, 876, 2616, 872, 868, 880, 2612, 872, 868, 872, 872, 872, 868, 876, 868, 872, 2616, 872, 872, 872, 868, 876, 868, 872, 868, 876, 868, 872, 868, 884, 860, 872, 2616, 872, 872, 872, 868, 872, 868, 876, 868, 872, 872, 3492, 3492, 872, 2616, 876, 868, 872, 896, 844, 2620, 872, 868, 872, 2620, 872, 868, 872, 872, 872, 2616, 872, 872, 872, 872, 868, 2620, 872, 868, 872, 2620, 868, 896, 848, 868, 876, 868, 872, 872, 868, 2620, 872, 872, 868, 872, 872, 868, 872, 872, 872, 896, 848, 868, 876, 868, 868, 2620, 872, 872, 868, 896, 848, 868, 872, 872, 872, 868, 3496, 3488, 876};
  if (Serial.read() != -1) {
        Serial.println("Send raw from fourth push");
        // altered the code just to send/test my raw code
        irsend.sendRaw(raw,465,40);
        delay(2000);
        Serial.println("Sent.. working?");

    }
  #endif 
  
}