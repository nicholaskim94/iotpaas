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
	gpio.write(MuxSelPinArray[1], gpio.HIGH)
	gpio.write(MuxSelPinArray[2], gpio.LOW)
	gpio.write(MuxSelPinArray[3], gpio.LOW)
	return (-12.5 + 125 x ((adc.read(0)÷1024))
end