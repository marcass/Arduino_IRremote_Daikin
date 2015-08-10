--check ip status and subscribe
if wifi.sta.status() == 5 and wifi.sta.getip() ~= nil then
   tmr.stop(0)
   tmr.stop(2)  
   m:connect("url of broker", 1883, 0, function(conn)
     m:subscribe("scott/com",1, function(conn)
     end)
   end)
end


--take the temperature every 10s if enough memory and publish for openhab to grab
tmr.alarm(1, 10000, 1, function()
  if node.heap() > 10500 then
        n = require("ds18b20")
	t = n.read()
	m:publish("temp/scott/state",t,0,0, function(conn)
	print(t.."C")
	n = nil
	ds18b20 = nil
	package.loaded["ds18b20"]=nil
        end )
  end
end)
