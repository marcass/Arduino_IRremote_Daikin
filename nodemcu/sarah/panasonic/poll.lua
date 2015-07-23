--mqtt.lua  

m = mqtt.Client("ESP8266 daikin", 180, "", "") --Last 2 values are user and password for broker

 m:lwt("lwt", "daikin", 0, 0)  
 m:on("offline", function(con)   
  dofile("offline.lua")
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

--do the sudbscribption business
 tmr.alarm(0, 1000, 1, function()  
   dofile("sub.lua")
 end)

--take the temperature every 10s if enough memory and publish for openhab to grab
tmr.alarm(1, 10000, 1, function()
  if node.heap() > 10500 then
	dofile("temp.lua")
   	m:publish("home/temp/pana/state",t,0,0, function(conn)
   	end )
  end
end)

