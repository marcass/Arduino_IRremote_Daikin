tmr.alarm(1,10000,1,function()    		
  -- A simple http client
  cox = "9ca270d7-5458-3b28-b70c-f25b9ae005d5"
  sk=net.createConnection(net.TCP, 0)
  sk:on("receive", function(sk, c) print(c) end)
  sk:dns("heatpump.webspeed.co.nz", function(sk,ip)
    addr=ip
    print(addr)
    --sk:connect(80,"192.168.0.9")
    sk:connect(80, addr)
    print("connecting...")
  --  sk:send("GET / HTTP/1.1\r\nHost:192.168.0.9\r\n"
    sk:send("GET /"..cox.." HTTP/1.1\r\nHost:"..addr.."\r\n"
        .."Connection: keep-alive\r\nAccept: */*\r\n\r\n")
       print("keeping alive")
  --  sk:close()
       print("Heap size"..node.heap())
   end)
  end)

