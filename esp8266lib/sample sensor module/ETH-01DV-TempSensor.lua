--Volatage input 3.3V
local gpio = gpio
local adc = adc
local MuxSelPinArray = MuxSelPinArray
module('ETH-01DV-TempSensor')
function SensorModel() return "ETH-01DV" end
function SensorType() return "Temperature" end
function Unit() return "Cellcius" end
function GetValue()
	gpio.mode(MuxSelPinArray[1], gpio.OUTPUT)
	gpio.mode(MuxSelPinArray[2], gpio.OUTPUT)
	gpio.mode(MuxSelPinArray[3], gpio.OUTPUT)
	gpio.write(MuxSelPinArray[1], gpio.HIGH)
	gpio.write(MuxSelPinArray[2], gpio.LOW)
	gpio.write(MuxSelPinArray[3], gpio.LOW)
	local value = (adc.read(0) / 1024)
	if (value > 0.1 and value < 0.9) then
		return (-66.875 + (218.75 * value))
	elseif (value <= 0.1) then
		return -45
	else
		return 130
	end
end