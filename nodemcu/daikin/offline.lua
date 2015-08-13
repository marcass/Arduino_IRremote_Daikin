--handling of connection dropouts that result in esp hanging wiuth mqtt trying to reconnect
print("offline started "..node.heap())
--register callbacks for wifi event monitor
  wifi.sta.eventMonReg(wifi.STA_IDLE, function() w = "1" end)
  wifi.sta.eventMonReg(wifi.STA_CONNECTING, function() w = "2" end)
  --wifi.sta.eventMonReg(wifi.STA_WRONGPWD, function() print("STATION_WRONG_PASSWORD") end)
  --wifi.sta.eventMonReg(wifi.STA_APNOTFOUND, function() print("STATION_NO_AP_FOUND") end)
  wifi.sta.eventMonReg(wifi.STA_FAIL, function() w = "3" end)
  wifi.sta.eventMonReg(wifi.STA_GOTIP, function() w = "4" end)

--cycle until connected again
tmr.alarm(4, 1000, 1, function()
  --register callbacks for wifi event monitor
  wifi.sta.eventMonReg(wifi.STA_IDLE, function() w = "1" end)
  wifi.sta.eventMonReg(wifi.STA_CONNECTING, function() w = "2" end)
  wifi.sta.eventMonReg(wifi.STA_FAIL, function() w = "3" end)
  wifi.sta.eventMonReg(wifi.STA_GOTIP, function() w = "4" end)
  wifi.sta.eventMonStart(200)
    if (w ~= 4) then
      print("Station lost connection with Access Point\n\tAttempting to reconnect...")
      wifi.sta.eventMonStop("unreg all")
    else
      print("Broker connection lost")
      tmr.stop(4)
      wifi.sta.eventMonStop("unreg all")
      dofile("sub.lua")
     end
end)
