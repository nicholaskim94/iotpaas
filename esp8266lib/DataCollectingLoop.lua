for i = 1, NumberOfData do
	local Module = require (DataModuleArray[i])
	print ("Loaded Module: "..DataModuleArray[i])
	local Value = Module.GetValue(adc.read(0))
	file.open("data.txt", "a+")
	file.writeline(GoogleTime..","..Module.SensorModel()..","..Module.SensorType()..","..Module.Unit()..","..Value)
end
file.flush()
file.close()
print("Sensor Information Added")
dofile ("CheckFile.lua")