--Volatage input 3.3V
local gpio = gpio
local adc = adc
local MuxSelPinArray = MuxSelPinArray
module('ETH-01DV-HumiditySensor')
function SensorModel() return "ETH-01DV" end
function SensorType() return "Humidity" end
function Unit() return "%RH" end
function GetValue()
	gpio.mode(MuxSelPinArray[1], gpio.OUTPUT)
	gpio.mode(MuxSelPinArray[2], gpio.OUTPUT)
	gpio.mode(MuxSelPinArray[3], gpio.OUTPUT)
	gpio.write(MuxSelPinArray[1], gpio.LOW)
	gpio.write(MuxSelPinArray[2], gpio.LOW)
	gpio.write(MuxSelPinArray[3], gpio.LOW)
	local value = (adc.read(0) / 1024)
	if (value > 0.1 and value < 0.9) then
		return (-12.5 + (125 * value))
	elseif (value <= 0.1) then
		return 0
	else
		return 100
	end
end