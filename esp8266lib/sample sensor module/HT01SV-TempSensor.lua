--Volatage input 3.3V
local gpio = gpio
local adc = adc
local MuxSelPinArray = MuxSelPinArray
module('HT01SV-TempSensor')
function SensorModel() return "HT01SV" end
function SensorType() return "TEMP" end
function Unit() return "Cellcius" end
function GetValue()
	gpio.mode(MuxSelPinArray[1], gpio.OUTPUT)
	gpio.mode(MuxSelPinArray[2], gpio.OUTPUT)
	gpio.mode(MuxSelPinArray[3], gpio.OUTPUT)
	gpio.write(MuxSelPinArray[1], gpio.LOW)
	gpio.write(MuxSelPinArray[2], gpio.LOW)
	gpio.write(MuxSelPinArray[3], gpio.LOW)
	return (adc.read(0)*165/3.3 - 40)
end