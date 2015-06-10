--[[
 Script for Julian's esp module that is called after successful wifi connection:
 - Called dostuff.lua
 - Sets up an http client
 - Polls page for current user-set state (on web page) "1" (on) or "0" (off) every 5min
 - Compares a stored state with polled state. If different;
 - Makes a pin output high that is connected to arduino (a pin for on and pin for off)
 - Idles again and repolls for a changed state
 - Also have a higher level of polling to see if the systeem needs to listen for on/off signals
 - make sure there are pull down resistors on the output pins!
--]]


-- Constants
	ON	= "state=1"
	OFF	= "state=0"
	
	-- Set state for start up (off): A sensible state
	powerstate = OFF
	PINON	= 6	-- set pin to pullup to send on signal
	PINOFF	= 5	-- set pin to pullup to send off signal
	
-- Setup hardware
	-- set pins to output
		-- set gpio "PINON" as output 
    		gpio.mode(PINON, gpio.OUTPUT) -- This should be declared in init.lua
		-- set gpio "PINOFF" as output 
    		gpio.mode(PINOFF, gpio.OUTPUT) -- This should be declared in init.lua
    		
-- A simple http client


conn=net.createConnection(net.TCP, 0)
conn:on("receive", function(conn, pl)
        if string.find(pl,"state=0") then gpio.write(PINOFF, gpio.HIGH) gpio.write(PINON, gpio.LOW) print("Turning off...")
        elseif string.find(pl,"state=1") then gpio.write(PINOFF, gpio.LOW) gpio.write(PINON, gpio.HIGH) print("Turning on...")
        elseif string.find(pl,"") then gpio.write(PINOFF, gpio.LOW) gpio.write(PINON, gpio.LOW) print ("Sleeping...") end

end)
conn:connect(80,"192.168.0.5")
conn:send("GET / HTTP/1.1\r\nHost: 192.168.0.5\r\n"
    .."Connection: keep-alive\r\nAccept: */*\r\n\r\n")
