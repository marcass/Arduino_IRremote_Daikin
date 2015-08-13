--poll.lua  

m = mqtt.Client(id, 180, buser, bpass) --Last 2 values are user and password for broker

 m:lwt(lwttop, "offline", 0, 0)  
   m:on("offline", function(con)   
	--do the subscrption business
 	tmr.alarm(2, 1000, 1, function()
   	dofile("sub.lua")
   end)
 end)  

 -- on publish message receive event  
 m:on("message", function(conn, topic, data)  
  if (data == "ON") then
      gpio.write(pinoff,gpio.LOW) gpio.write(pinon,gpio.HIGH)
      print("Toggling panasonic..")
      gpio.write(pinoff,gpio.LOW) gpio.write(pinon,gpio.LOW)
  else
      print("Invalid, ignoring")
      gpio.write(pinoff,gpio.LOW) gpio.write(pinon,gpio.LOW)
  end
 end)  

--do the subscription business
 tmr.alarm(0, 1000, 1, function()  
   dofile("sub.lua")
 end)

