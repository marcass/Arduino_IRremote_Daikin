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
	ON	= "1" --variable returned in webpage
	OFF	= "0" --variable returned in webpage
	w	= "192.168.0.5" -- host for connection
	
-- Setup hardware (this is done in init.lua)
--Set sleep function
function sleep()
	gpio.write(PINOFF,gpio.LOW) gpio.write(PINON,gpio.LOW)
	print("Sleeping...")
end


    		
-- A simple http client
conn=net.createConnection(net.TCP, 0)
conn:on("receive", function(conn, pl)  
	if string.find(pl,OFF) then 
	  gpio.write(PINOFF, gpio.HIGH) gpio.write(PINON, gpio.LOW) print("Turning off...")
        elseif string.find(pl,ON) then 
	  gpio.write(PINOFF, gpio.LOW) gpio.write(PINON, gpio.HIGH) print("Turning on...")
	elseif string.find(pl,"") then 
	  sleep() print ("Sleeping. No useful state fetched") 
	end
end)

--conn:connect(80,"192.168.0.5")
conn:connect(80, w)
        sleep() --pulls pins down in case of failed connection
--conn:send("GET / HTTP/1.1\r\nHost: 192.168.0.5\r\n"
conn:send("GET / HTTP/1.1\r\nHost:w\r\n"
    .."Connection: keep-alive\r\nAccept: */*\r\n\r\n")
