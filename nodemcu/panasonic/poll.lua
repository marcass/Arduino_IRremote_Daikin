--poll.lua  

-- set the following variables in-file (short on memory)
--client id for mqtt
--url/ip of broker
 --broker username
--broker password
--last will and testament topic
--heating topic
--temperature topic

--client id for mqtt
--broker username
--broker password
m = mqtt.Client("<client id>", 180, "mqtt user", "mqtt pass") 
--last will and testament topic
m:lwt("<lwt topic>", "offline", 0, 0)  
m:on("offline", function(conn)   
  --do the subscription business
  print("MQTT reconnecting")
  tmr.stop(0)
  dofile("offline.lua")
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
  --check ip status and subscribe
  if wifi.sta.status() == 5 and wifi.sta.getip() ~= nil then
    tmr.stop(0)
    m:connect("<broker url/ip>", 8883, 1, function(conn)
      tmr.stop(4)
      --heating topic
      m:subscribe("<heatpump topic>",1, function(conn)
      end)
      --take the temperature every 10s if enough memory and publish for openhab to grab
      print("start temp") print(node.heap())
      tmr.alarm(1, 10000, 1, function()
        n = require("ds18b20")
        t = n.read()
        --temperature topic
        m:publish("<temp topic>",t,0,0, function(conn)
          print(t.."C")
        end)
        n = nil
        ds18b20 = nil
        package.loaded["ds18b20"]=nil
      end)
    end)
  end
end)
