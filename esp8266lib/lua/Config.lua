--GLOBAL VARIABLE
SSID = "HandS_2.4G" --Put Your Wifi SSID on Here!
Pass = "hands1986" --Put Your Wifi Password on Here!
TimeOut = Nil --Connection Closed after Timour, Put Nil to Run 'connect_wifi.lua' until Wifi Connected!
Host = "NodeMCU01"  -- set Host																				Needed
Url = "" -- set server Url without http://																	Needed
IP = ""
ReqType = "POST"
Location = nil
UploadInterval = 10000 -- Unit: ms 																			Needed
MuxSelPinArray = {0, 1, 2} --muxpin setting	0, 1, 2 for sel pin												Needed
MuxEnablePin = 3 --muxpin enable pin setting																Needed
if (MuxEnablePin) then
	gpio.mode(MuxEnablePin, gpio.OUTPUT)
	gpio.write(MuxEnablePin, gpio.LOW)
end
NumberOfData = 1 -- numbers to collect data from mux or serial communication								Needed
DataModuleArray = {"TempSensor", "HumiditySensor", "GasSensor"}
Header = "Host: "..Host.."\r\n"..
		"Connection: Keep-Alive\r\n"..
		"Authorization: \r\n"..
		"Content-Type: application/json\r\n"
DataContainer = {
    ["projectName"] = "hi",
    ["sensorModel"] = "TI000001",
    ["sensorType"]= "Thermal",
    ["unit"] = "Celcius",
    ["time"] = "",
    ["value"] = 110,
    ["lat"] = 0,
    ["lng"] = 0,
	["access_token"] = "16586e3d75a12ea0c560ed5045ee9af1"
}