for i = 1, NumberOfData do
	local remaining, used, total = file.fsinfo()
	local Module = require (DataModuleArray[i])
	print ("Loaded Module: "..DataModuleArray[i])
	local Value = Module.GetValue(adc.read(0))
	if wifi.sta.getip() ~= nil then
    	DataContainer["time"] = GoogleTime
    	DataContainer["sensorModel"] = Module.SensorModel()
    	DataContainer["sensorType"] = Module.SensorType()
    	DataContainer["unit"] = Module.Unit()
    	DataContainer["value"] = Value
    	dofile ("Request.lua")
    elseif (remaining > 1024*10) then
    	file.open("data.txt", "a+")
		file.writeline(GoogleTime..","..Module.SensorModel()..","..Module.SensorType()..","..Module.Unit()..","..Value)
		file.flush()
		file.close()
    else
    	print ("Neither Wifi Connected nor Enough Memory Left")
    end
end