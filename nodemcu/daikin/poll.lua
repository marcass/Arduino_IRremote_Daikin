--mqtt.lua  

m = mqtt.Client("id", 180, "user", "pass") 
m:lwt("lwt top", "offline", 0, 0)  
m:on("offline", function(conn)   
	--do the subscription business
	print("MQTT reconnecting")
	--tmr.alarm(2, 1000, 1, function()
   	dofile("offline.lua")
 	--end)
 end)  

 -- on publish message receive event  
 m:on("message", function(conn, topic, data)  
  if (data == "ON") then
	h = 1
  elseif (data == "OFF") then
	h = 0
  end
  dofile("switch.lua")	
 end)  

--do the subscription business
 tmr.alarm(0, 1000, 1, function()  
   --start wifi status monitor to catch connection dropouts and esp hangs
   --wifi.sta.eventMonStart()
   dofile("sub.lua")
 end)


