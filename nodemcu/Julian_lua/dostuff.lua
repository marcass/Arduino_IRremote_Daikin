--[[
 Script for Julian's esp module that is called after successful wifi connection:
 - Called dostuff.lua
 - Sets up an http client
 - Polls page for current user-set state (on web page) "1" (on) or "0" (off) every 5min
 - Compares a stored state with polled state. If different;
 - Makes a pin output high that is connected to arduino (a pin for on and pin for off)
 - Idles again and repolls for a changed state
--]]

-- Constants
	ON	= "1"
	OFF	= "0"
	-- Set state for start up (off): A sensible state
	powerstate = OFF
	PINON	= 1	-- set pin to pullup to send on signal
	pinoff	= 2	-- set pin to pullup to send off signal
	
-- Setup hardware
	-- set pins to output
		-- set gpio "PINON" as output and pulldown
    		gpio.mode(PINON, gpio.OUTPUT)
    		gpio.write(PINON, gpio.LOW)
		-- set gpio "PINOFF" as output and pulldown
    		gpio.mode(PINOFF, gpio.OUTPUT)
    		gpio.write(PINOFF, gpio.LOW)
    		
-- A simple http client
	conn=net.createConnection(net.TCP, 0) 
	conn:on("receive", function(conn, pl) print(pl) end)
	conn:connect(80,"<mw insert ip here>")
	conn:send("GET / HTTP/1.1\r\nHost: <mw insert url here>\r\n"
	    .."Connection: keep-alive\r\nAccept: */*\r\n\r\n") -- The .. is the string concatenate string operator. 
    
-- poll the webpage (soemhow)
function POLLPAGE() 
	-- poll page, compare values and do pins (if necc)
    
	-- input the polled value as "payload"
	-- never use node.input() in console. no effect.
	sk:on("receive", function(conn, payload) node.input(payload) end)
end

-- run the poll funtion every 5min (60000 milliseconds). Timer "0", 5min delay, 1=repeat (0=one time alarm)
    tmr.alarm(0, 60000, 1, function() POLLPAGE) end )


-- delay 5 min = 60000us at end of function before starting the polling again
tmr.delay(60000)