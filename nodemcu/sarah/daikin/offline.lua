--obseleted this file
local broker = "192.168.0.3"
   print ("Mqtt Reconnecting...")   
   tmr.alarm(1, 1000, 0, function()  
     m:connect(broker, 1883, 0, function(conn)   
        m:subscribe("home/heat/dai/com",0, function(conn)
      end)
      end)  
    end) 
