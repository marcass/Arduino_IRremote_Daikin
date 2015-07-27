
--Constants
local	ON	= "|~1" --variable returned in webpage
local	OFF	= "|~0" --variable returned in webpage
	
local  cox = "9ca270d7-5458-3b28-b70c-f25b9ae005d5"

local  sk=net.createConnection(net.TCP, 0)
  sk:on("receive", function(sk, c) 
	if string.find(c,OFF) then 
	  gpio.write(5, gpio.HIGH) gpio.write(6, gpio.LOW) 
          gpio.write(5, gpio.LOW) gpio.write(6, gpio.LOW)
	  print("Turning off...")
        elseif string.find(c,ON) then 
	  gpio.write(5, gpio.LOW) gpio.write(6, gpio.HIGH) 
          gpio.write(5, gpio.LOW) gpio.write(6, gpio.LOW)
	  print("Turning on...")
	else 
          gpio.write(5,gpio.LOW) gpio.write(6,gpio.LOW)
	end
  end)
  sk:dns("heatpump.webspeed.co.nz", function(sk,ip)
    local addr=ip
    print(addr)
    --sk:connect(80,"192.168.0.9")
    sk:connect(80, addr)
    print("connecting...")
  --  sk:send("GET / HTTP/1.1\r\nHost:192.168.0.9\r\n"
    sk:send("GET /"..cox.." HTTP/1.1\r\nHost:"..addr.."\r\n"
        .."Connection: keep-alive\r\nAccept: */*\r\n\r\n")
       print("closing")
       sk:close()
       print("Heap size"..node.heap())
   end)

sk = nil
addr = nil
ON = nil
OFF = nil
cox = nil
