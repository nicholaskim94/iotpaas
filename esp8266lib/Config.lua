--GLOBAL VARIABLE
SSID = "dongap" --Put Your Wifi SSID on Here!
Pass = "47984810" --Put Your Wifi Password on Here!
GoogleGeoLocationAPI = "" --your google api key
TimeOut = 10000 --Connection Closed after Timor, Put Nil to Run 'connect_wifi.lua' until Wifi Connected!
Host = "NodeMCU01"  -- set Host
IP = "54.175.219.8"
Path = "/post"
ReqType = "POST"
Location = nil
UploadInterval = 10000 -- Unit: ms
MuxSelPinArray = {0, 1, 2} --muxpin setting	0, 1, 2 for sel pin
MuxEnablePin = 3 --muxpin enable pin setting
if (MuxEnablePin) then
	gpio.mode(MuxEnablePin, gpio.OUTPUT)
	gpio.write(MuxEnablePin, gpio.LOW)
end
NumberOfData = 1 -- numbers to collect data from mux or serial communication
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
	["access_token"] = "16586e3d75a12ea0c560ed5045ee9af1" -- put your access_token
}