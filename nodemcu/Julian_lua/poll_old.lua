tmr.alarm(0,5000,1,function()
  dofile("sk.lua")
  print("another loop "..node.heap())
  
end )
