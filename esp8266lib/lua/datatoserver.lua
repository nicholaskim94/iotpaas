--set 8channel Mux as output
gpio.mode(Mux1, gpio.OUTPUT)
gpio.mode(Mux2, gpio.OUTPUT)
gpio.mode(Mux3, gpio.OUTPUT)
local Request = assert(loadfile("Request.lua"), "Loading Request.lua failed")
require "GetTime"
Time = nil
--set lag and lan here
function split(pString, pPattern)
   local Table = {} 
   local fpat = "(.-)" .. pPattern
   local last_end = 1
   local s, e, cap = pString:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	  table.insert(Table,cap)
      end
      last_end = e+1
      s, e, cap = pString:find(fpat, last_end)
   end
   if last_end <= #pString then
      cap = pString:sub(last_end)
      table.insert(Table, cap)
   end
   return Table
end
tmr.alarm(1, 1000, 1, function()
	Time = GetTime.GetTime()
end)
tmr.alarm(1, 10000, 1, function()
	for i = 0, 7 do--number of Mux on adc port
	if i % 2 ~= 0 then gpio.write(Mux1, gpio.HIGH) else gpio.write(Mux1, gpio.LOW) end
	if i % 4 > 1 then gpio.write(Mux2, gpio.HIGH) else gpio.write(Mux2, gpio.LOW) end
	if i > 3 then gpio.write(Mux3, gpio.HIGH) else gpio.write(Mux3, gpio.LOW) end
	--put your code here
	if i == 0 then pcall(TempHumSensor) end
	file.open("data.txt", "a+")
	file.writeline(Time..",TQWQR1"..",TEMP"..",Cellcius,".."0")
	--file.flush()
	print("Sensor Information Added")
	file.close()
	end
end)
tmr.alarm(2, 10000, 1, function()
	file.open("data.txt", "r")
	file.seek("set")
	local Line = file.readline()
	--print (Line)
	while Line do
		data["time"],data["sensorModel"],data["sensorType"],data["unit"],data["value"] = split(Line, ",")
		if wifi.sta.getip() ~= nil then
			print (data)
			pcall (Request, DataContainer)
			Line = file.readline()
		else
			print("Internet Connection Lost")
			break
		end
	end
	--file.wirte(file.read())
	file.close()
end)

--dofile("init.lua")