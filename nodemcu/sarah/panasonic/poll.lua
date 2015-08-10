--mqtt.lua  

m = mqtt.Client("ESP8266 pana", 180, "", "") --Last 2 values are user and password for broker

 m:lwt("panasonic", "offline", 0, 0)  
   m:on("offline", function(con)   
	print(node.heap())
	--do the subscrption business
 	tmr.alarm(2, 1000, 1, function()
   	dofile("sub.lua")
   end)
 end)  

 -- on publish message receive event  
 m:on("message", function(conn, topic, data)  
  if (data == "ON") then
      gpio.write(5,gpio.LOW) gpio.write(6,gpio.HIGH)
      print("Turning panasonic on..")
      gpio.write(5,gpio.LOW) gpio.write(6,gpio.LOW)
  else
      print("Invalid, ignoring")
      gpio.write(5,gpio.LOW) gpio.write(6,gpio.LOW)
  end
  print(node.heap())
 end)  

--do the subscription business
 tmr.alarm(0, 1000, 1, function()  
   dofile("sub.lua")
 end)


