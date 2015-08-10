--mqtt.lua  

m = mqtt.Client("ESP8266 scott", 180, "", "") --Last 2 values are user and password for broker

 m:lwt("scott", "offline", 0, 0)  
 m:on("offline", function(conn)   
	--do the subscription business
	print("MQTT reconnecting")
	tmr.alarm(2, 1000, 1, function()
   	dofile("sub.lua")
 	end)
 end)  

 -- on publish message receive event  
 m:on("message", function(conn, topic, data)  
  if (data == "ON") then
	h = 1
  elseif (data == "OFF") then
	h = 0
  end
  dofile("switch.lua")	
  print(node.heap())
 end)  

--do the subscription business
 tmr.alarm(0, 1000, 1, function()  
   dofile("sub.lua")
 end)


