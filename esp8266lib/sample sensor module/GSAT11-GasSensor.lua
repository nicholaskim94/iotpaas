local gpio = gpio
local adc = adc
local MuxSelPinArray = MuxSelPinArray
module('GSAT11-GasSensor')
function SensorModel() return "GSAT11" end
function SensorType() return "Gas" end
function Unit() return "ppm" end
function GetValue()
	gpio.mode(MuxSelPinArray[1], gpio.OUTPUT)
	gpio.mode(MuxSelPinArray[2], gpio.OUTPUT)
	gpio.mode(MuxSelPinArray[3], gpio.OUTPUT)
	gpio.write(MuxSelPinArray[1], gpio.LOW)
	gpio.write(MuxSelPinArray[2], gpio.HIGH)
	gpio.write(MuxSelPinArray[3], gpio.LOW)
	return ((adc.read(0)-340)*240/330)
end