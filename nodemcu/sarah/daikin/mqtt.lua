--mqtt.lua  

DeviceID="dai"
TypeID="heat"
Broker="192.168.0.3"
-- For debugging

 m = mqtt.Client("ESP8266".. DeviceID, 180, "", "") --Last 2 values are "user and "password" for broker
 m:lwt("/lwt", "ESP8266", 0, 0)  
 m:on("offline", function(con)   
    print ("Mqtt Reconnecting...")   
    tmr.alarm(1, 1000, 0, function()  
      m:connect(Broker, 1883, 0, function(conn)   
        print("Mqtt Connected to:" .. Broker)  
        --run the subscription function  
        m:subscribe("home/".. TypeID .."/" .. DeviceID .. "/com",0, function(conn)
        print("Mqtt Subscribed to OpenHAB feed for device " .. DeviceID)
	end)
      end)  
    end)  
 end)  
--debug
print("Subscription begin after being offline")
printi(node.heap())


 -- on publish message receive event  
 m:on("message", function(conn, topic, data)   
    print("Recieved:" .. topic .. ":" .. data)   
      if (data=="ON") then  
	gpio.write(PINOFF,gpio.LOW) gpio.write(PINON,gpio.HIGH)
        print("Turning Daikin on..")
	tmr.delay(2000000)
	gpio.write(PINOFF,gpio.LOW) gpio.write(PINON,gpio.LOW)
    elseif (data=="OFF") then  
	gpio.write(PINOFF,gpio.HIGH) gpio.write(PINON,gpio.LOW)
        print("Turning Daikin off..")
	tmr.delay(2000000)
        gpio.write(PINOFF,gpio.LOW) gpio.write(PINON,gpio.LOW)
    else  
      print("Invalid - Ignoring")   
      gpio.write(PINOFF,gpio.LOW) gpio.write(PINON,gpio.LOW)
    end   
 end)  
--debug
print("Subscription received")
print(node.heap())

--do the sudbscribption business
 tmr.alarm(0, 1000, 1, function()  
  if wifi.sta.status() == 5 and wifi.sta.getip() ~= nil then  
    tmr.stop(0)  
    m:connect(Broker, 1883, 0, function(conn)   
      print("Mqtt Connected to:" .. Broker)  
      --run the subscription function  
      m:subscribe("home/".. TypeID .."/" .. DeviceID .. "/com",0, function(conn)
      print("Mqtt Subscribed to OpenHAB feed for device " .. DeviceID)
      end)
    end)  
  end  
 end)
print("Subscription begin")
print(node.heap())

--take the temperature every 30s and publish for openhab to grab
tmr.alarm(1, 30000, 1, function()
  require('ds18b20')
  -- ESP-12 GPIOO4 Mapping lua pin 2
  temp = 2
  ds18b20.setup(temp)
  t1=ds18b20.read()
  t1=ds18b20.read()
  m:publish("home/temp/"..DeviceID.."",t1,0,0, function(conn) print("sent temp="..t1.."C") end)
  --debug
  print("temp loaded")
  print(node.heap())
  --release after use
  ds18b20 = nil
  package.loaded["ds18b20"]=nil
  --debug
  print("temp unloaded")
  print(node.heap())
end)
