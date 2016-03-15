--GLOBAL VARIABLE
SSID = "iptimenetis" --Put Your Wifi SSID on Here!
Pass = "12345678" --Put Your Wifi Password on Here!
TimeOut = 10000 --Connection Closed after Timor, Put Nil to Run 'connect_wifi.lua' until Wifi Connected!
Host = node.chipid()  -- set Host
IP = "127.0.0.1" -- set your IP
PORT = 8080
SECURITY = 0
Path = "/index.html"
EncodeType = "url" -- select json or url
ReqType = "POST"
UploadInterval = 10000 -- Unit: ms
MuxSelPinArray = {0, 1, 2} --muxpin setting	0, 1, 2 for sel pin
MuxEnablePin = 3 --muxpin enable pin setting
if (MuxEnablePin) then
	gpio.mode(MuxEnablePin, gpio.OUTPUT)
	gpio.write(MuxEnablePin, gpio.LOW)
end
DataModuleArray = {"HT01SV-TempSensor"}
Header = "Host: "..Host.."\r\n"..
		"Authorization: \r\n"..
		"Content-Type: application/json\r\n"
DataContainer = {
    ["projectName"] = "hi",
    ["sensorModel"] = "TI000001",
    ["sensorType"]= "Thermal",
    ["unit"] = "Celcius",
    ["time"] = "",
    ["value"] = 110,
    ["location"] = "My Room",
	["access_token"] = "16586e3d75a12ea0c560ed5045ee9af1" -- put your access_token
}