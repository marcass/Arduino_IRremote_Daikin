-- init.lua script with timers that wait for wifi connection before executing 
-- heavy lifing

-- Constants
--SSID    = "" 		-- change to ssid
--APPWD   = ""	-- change to password
--CMDFILE = "poll.lua"  		-- File that is executed after connection
--INTERVAL= "30000"  -- 3ssec
--PINON	= 6
--PINOFF	= 5

-- Some control variables
--wifiTrys     = 0      -- Counter of trys to connect to wifi
--NUMWIFITRYS  = 200    -- Maximum number of WIFI Testings while waiting for connection

-- Set pin state so it dones't turn heatpump on at power failure
gpio.mode(6, gpio.OUTPUT)
gpio.write(6, gpio.LOW)
gpio.mode(5, gpio.OUTPUT)
gpio.write(5, gpio.LOW)


function checkWIFI() 
  wifiTrys     = 0      -- Counter of trys to connect to wifi
  NUMWIFITRYS  = 200    -- Maximum number of WIFI Testings while waiting for connection
  if ( wifiTrys > NUMWIFITRYS ) then
    print("Sorry. Not able to connect")
  else
    ipAddr = wifi.sta.getip()
    if ( ( ipAddr ~= nil ) and  ( ipAddr ~= "0.0.0.0" ) )then
      tmr.alarm( 1 , 500 , 0 , function()
	  --launch file
	  print("Connected to WIFI!")
	  print("IP Address: " .. wifi.sta.getip())
	  dofile("poll.lua")
      end )
    else
      -- Reset alarm again
      tmr.alarm( 0 , 2500 , 0 , checkWIFI)
      print("Checking WIFI..." .. wifiTrys)
      wifiTrys = wifiTrys + 1
    end 
  end 
wifiTrys     = nil      -- Counter of trys to connect to wifi
NUMWIFITRYS  = nil    -- Maximum number of WIFI Testings while waiting for connection
ipAddr       = nil
end

print("-- Starting up! ")

-- Lets see if we are already connected by getting the IP
ipAddr = wifi.sta.getip()
if ( ( ipAddr == nil ) or  ( ipAddr == "0.0.0.0" ) ) then
  -- We aren't connected, so let's connect
  print("Configuring WIFI....")
  wifi.setmode( wifi.STATION )
--put wifi details in here
  wifi.sta.config( "ssid", "p/w")
  print("Waiting for connection")
  tmr.alarm( 0 , 2500 , 0 , checkWIFI )  -- Call checkWIFI 2.5S in the future.
else
 -- We are connected, so just run the launch code.
  print("Connected to WIFI!")
  print("IP Address: " .. wifi.sta.getip())
  dofile("poll.lua")
end
ipAddr = nil
-- Drop through here to let NodeMcu run
print("Post connection")
print(node.heap())
