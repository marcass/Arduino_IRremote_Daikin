
#include <FujitsuHeatpumpIR.h> // NEEDED FOR SENDING IR
IRSender irSender(3); // IR led
HeatpumpIR *heatpumpIR = new FujitsuHeatpumpIR();

// constants won't change. They're used here to set pin numbers:
int LED=13; // STATUS INDICATION
const int PinOn = 2;     // the number of the pin for on
const int PinOff = 8;     // the number of the pin for off


// variables will change:
int OnState = 0;         // variable for reading the pin status
int OffState = 1;         // variable for reading the pin status


void setup()
{
 pinMode(LED, OUTPUT);  // Setup LED pin
 Serial.begin(9600);    // Start serial port
 pinMode(PinOn, INPUT);
 digitalWrite(PinOn, LOW);
 pinMode(PinOff, INPUT);
 digitalWrite(PinOff, LOW);
}



void loop()
{
  // read the state of the input pin value:
  OnState = digitalRead(PinOn);
  OffState = digitalRead(PinOff);
  int temp = 25;
  
   if (OnState == HIGH && OffState == LOW) {
      // MODE: MODE_AUTO, MODE_HEAT, MODE_COOL, MODE_DRY, MODE_FAN
      // FAN: FAN_AUTO, FAN_1, FAN_2, FAN_3, FAN_4
      digitalWrite(LED, HIGH);
      heatpumpIR->send(irSender, POWER_ON, MODE_HEAT, FAN_AUTO, temp, VDIR_UP, HDIR_AUTO);
    }
    if (OnState == LOW && OffState == HIGH) {
      digitalWrite(LED, LOW);
      heatpumpIR->send(irSender, POWER_OFF, MODE_HEAT, FAN_AUTO, temp, VDIR_UP, HDIR_AUTO);
    }
    delay(10);
  }
}

