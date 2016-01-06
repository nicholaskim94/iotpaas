--set 8channel mux as output
mux1, mux2, mux3 = 1, 2, 3
gpio.mode(mux1, gpio.OUTPUT)
gpio.mode(mux2, gpio.OUTPUT)
gpio.mode(mux3, gpio.OUTPUT)

tmr.alarm(1, 10000, 1, function() --set interval to upload data, unit:ms
if WIFI.STA.GETIP() != nil then
	for i=0, 7 --number of mux on adc port
	if i%2 != 0 then gpio.write(mux1, gpio.HIGH) else gpio.write(mux1, gpio.LOW) end
	if i%4 > 1 then gpio.write(mux2, gpio.HIGH) else gpio.write(mux2, gpio.LOW) end
	if i>3 then gpio.write(mux3, gpio.HIGH) else gpio.write(mux3, gpio.LOW) end
	adc.read(0)
	data = {
    "projectName": "TestApp",
    "sensorModel": "TI000001",
    "sensorType": "Thermal",
    "unit": "Celcius",
    "time": "2016-01-05",
    "value": 19,
    "lat": 0,
    "lng": 0
	}
	end
else

end
end
dofile("init.lua")