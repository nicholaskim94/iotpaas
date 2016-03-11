module('TempSensor', package.seeall)
SensorModel = "TQWQR1"
SensorType = "TEMP"
Unit = "Cellcius"
function GetValue()
	gpio.mode(MuxGPIOArray[0], gpio.OUTPUT)
	gpio.mode(MuxGPIOArray[1], gpio.OUTPUT)
	gpio.mode(MuxGPIOArray[2], gpio.OUTPUT)
	gpio.write(MuxGPIOArray[0], gpio.LOW)
	gpio.write(MuxGPIOArray[1], gpio.LOW)
	gpio.write(MuxGPIOArray[2], gpio.LOW)
	return (adc.read(0)*165/3.3 - 40)
end
