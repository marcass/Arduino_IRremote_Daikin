--mqtt.lua  
 
DeviceID="daikin"  
RoomID="hall"  
Broker="enter pi ip here"  

-- Setup hardware (this in done in init.lua)

--Set sleeping parameters
function sleep()
	gpio.write(PINOFF,gpio.LOW) gpio.write(PINON,gpio.LOW)
end

 m = mqtt.Client("ESP8266".. DeviceID, 180, "user", "password")  
 m:lwt("/lwt", "ESP8266", 0, 0)  
 m:on("offline", function(con)   
    print ("Mqtt Reconnecting...")   
    tmr.alarm(1, 10000, 0, function()  
      m:connect(Broker, 1883, 0, function(conn)   
        print("Mqtt Connected to:" .. Broker)  
        mqtt_sub() --run the subscription function  
      end)  
    end)  
 end)  

 -- on publish message receive event  
 m:on("message", function(conn, topic, data)   
    print("Recieved:" .. topic .. ":" .. data)   
      if (data=="ON") then  
      print("Turning on")   
      gpio.write(PINON,gpio.HIGH)  gpio.write(PINOFF,gpio.LOW)
      m:publish("/home/".. RoomID .."/" .. DeviceID .. "/p1/state","ON",0,0)  
    elseif (data=="OFF") then  
      print("Turning off")   
      gpio.write(PINOFF,gpio.HIGH) gpio.write(PINON,gpio.LOW) 
      m:publish("/home/".. RoomID .."/" .. DeviceID .. "/p1/state","OFF",0,0)  
    else  
      print("Invalid - Ignoring") sleep()
    end   
-- Need a fucniton in here that resets the pins to low after successful read at arduino
   tmr.delay(60000) -- sleep for 1min
   sleep() -- pull pins down
end)  
 function mqtt_sub()  
    m:subscribe("/home/".. RoomID .."/" .. DeviceID .. "/p1/com",0, function(conn)   
      print("Mqtt Subscribed to OpenHAB feed for device " .. DeviceID)  
    end)  
 end  
 tmr.alarm(0, 1000, 1, function()  
  if wifi.sta.status() == 5 and wifi.sta.getip() ~= nil then  
    tmr.stop(0)  
    m:connect(Broker, 1883, 0, function(conn)   
      print("Mqtt Connected to:" .. Broker)  
      mqtt_sub() --run the subscription function  
    end)  
  end  
 end)
