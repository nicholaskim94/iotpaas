--GLOBAL VARIABLE
SSID = "SSID" --Put Your Wifi SSID on Here!
Pass = "PASSWORD" --Put Your Wifi Password on Here!
TimeOut = Nil --Connection Closed after Timour, Put Nil to Run 'connect_wifi.lua' until Wifi Connected!
Host = "NodeMCU01"  -- set host
Url = "" -- set server url
ReqType = "POST"
Location = nil
Mux1, Mux2, Mux3 = 1, 2, 3 --muxpin setting
Header = "Host: "..Host.."\r\n"..
		"Connection: Keep-Alive\r\n"..
		"Authorization: \r\n"..
		"Content-Type: application/json\r\n"
DataContainer = {
    ["projectName"] = "hi",
    ["sensorModel"] = "TI000001",
    ["sensorType"]= "Thermal",
    ["unit"] = "Celcius", 	-- Needed
    ["time"] = "",			-- Needed
    ["value"] = 110,		-- Needed
    ["lat"] = 0,
    ["lng"] = 0,
	["access_token"] = "16586e3d75a12ea0c560ed5045ee9af1"
}