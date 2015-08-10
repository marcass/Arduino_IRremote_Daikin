-- file to deal with mqtt input

print("starting switch")
print(node.heap())
if h == 1  then
      gpio.write(5,gpio.LOW) gpio.write(6,gpio.HIGH)
      print("Turning Daikin on..")
      gpio.write(5,gpio.LOW) gpio.write(6,gpio.LOW)  
elseif h == 0  then
      gpio.write(5,gpio.HIGH) gpio.write(6,gpio.LOW)
      print("Turning Daikin off..")
      gpio.write(5,gpio.LOW) gpio.write(6,gpio.LOW)
else
      print("Invalid - Ignoring")   
      gpio.write(5,gpio.LOW) gpio.write(6,gpio.LOW)
end
h = nil
