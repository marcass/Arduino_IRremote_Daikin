-- file to deal with mqtt input

print("starting switch")
if h == 1  then
      gpio.write(pinoff,gpio.LOW) gpio.write(pinon,gpio.HIGH)
      print("Turning Daikin on..")
      gpio.write(pinoff,gpio.LOW) gpio.write(pinon,gpio.LOW)  
elseif h == 0  then
      gpio.write(pinoff,gpio.HIGH) gpio.write(pinon,gpio.LOW)
      print("Turning Daikin off..")
      gpio.write(pinoff,gpio.LOW) gpio.write(pinon,gpio.LOW)
else
      print("Invalid - Ignoring")   
      gpio.write(pinoff,gpio.LOW) gpio.write(pinon,gpio.LOW)
end
h = nil
