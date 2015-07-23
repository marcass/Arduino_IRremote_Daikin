--read temp on ds18b20

    local addr      = nil
    local count     = 0
    local data      = nil
    local pin       = 2             -- pin connected to DS18B20
    local s         = ''

    -- setup gpio pin for oneWire access
    ow.setup(pin)

    -- do search until addr is returned
    repeat
        count   = count + 1
        addr    = ow.reset_search(pin)
        addr    = ow.search(pin)
        tmr.wdclr()
        until((addr ~= nil) or (count > 100))
    -- if addr was never returned, abort
    if (addr == nil) then
        print('DS18B20 not found')
        end
  
    -- validate addr checksum
    crc = ow.crc8(string.sub(addr,1,7))
    if (crc ~= addr:byte(8)) then
        print('DS18B20 Addr CRC failed');
        end

    if not((addr:byte(1) == 0x10) or (addr:byte(1) == 0x28)) then
        print('DS18B20 not found')
        end
        
    ow.reset(pin)               -- reset onewire interface
    ow.select(pin, addr)        -- select DS18B20
    ow.write(pin, 0x44, 1)      -- store temp in scratchpad
    tmr.delay(1000000)          -- wait 1 sec
    present = ow.reset(pin)     -- returns 1 if dev present
    if present ~= 1 then
        print('DS18B20 not present')
        end
    
    ow.select(pin, addr)        -- select DS18B20 again
    ow.write(pin,0xBE,1)        -- read scratchpad
    -- rx data from DS18B20
    data = nil
    data = string.char(ow.read(pin))
    for i = 1, 8 do    
        data = data .. string.char(ow.read(pin))
        end
    

    -- validate data checksum
    crc = ow.crc8(string.sub(data,1,8))
    if (crc ~= data:byte(9)) then
        print('DS18B20 data CRC failed')
        end

    -- compute and return temp as C
    t = (data:byte(1) + data:byte(2) * 256) * 625 / 10000

--publish result
   print(t.."C")

--clear varialbes
addr      = nil
count     = nil
data      = nil
pin       = nil            
s         = nil
