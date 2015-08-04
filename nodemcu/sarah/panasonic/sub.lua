  if wifi.sta.status() == 5 and wifi.sta.getip() ~= nil then
     tmr.stop(0)  
     m:connect("192.168.0.3", 1883, 0, function(conn)
       m:subscribe("home/heat/pana/com",2, function(conn)
       end)
     end)
   end

--take the temperature every 10s if enough memory and publish for openhab to grab
tmr.alarm(1, 10000, 1, function()
  if node.heap() > 10500 then
        dofile("temp.lua")
        m:publish("home/temp/pana/state",t,0,0, function(conn)
        end )
  end
  print(node.heap())
end)
