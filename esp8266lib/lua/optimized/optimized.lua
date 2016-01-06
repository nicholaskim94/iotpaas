print("set up wifi mode\n")
local arg = {...}
wifi.setmode(wifi.STATION)
wifi.sta.config("SSID", "PASSWORD")
print("Connecting to SSID: "..arg[1].." Password: "..arg[2].."\n")
wifi.sta.connect()
function normalparser(t) local result = "" for k,v in pairs(t) do result = result.."&"..k.."="..v end return string.sub(result, 2) end
function jsonparser(t) local result = "{" for k,v in pairs(t) do result = result..'"'..k..'":"'..v..'",' end return string.sub(result,0,-2)..'}' end
conn=net.createConnection(net.TCP, 0) 
conn:on("receive", function(sck, pl) print(pl) end)
conn:dns(url:match("[%w]*%..*%w+%.%w+%/(.*)"),function(conn,ip) print(ip) end)
conn:connect(80, url:match("[%w]*%.(.*%w+%.%w+)%/.*")) --parse domain from url
gpio.mode(1, gpio.OUTPUT)
gpio.mode(2, gpio.OUTPUT)
gpio.mode(3, gpio.OUTPUT)
tmr.alarm(1, 10000, 1, function() --set interval to upload data, unit:ms
if WIFI.STA.GETIP() != nil then
	for i=0, 7 --number of mux on adc port
	if i%2 != 0 then gpio.write(mux1, gpio.HIGH) else gpio.write(mux1, gpio.LOW) end
	if i%4 > 1 then gpio.write(mux2, gpio.HIGH) else gpio.write(mux2, gpio.LOW) end
	if i>3 then gpio.write(mux3, gpio.HIGH) else gpio.write(mux3, gpio.LOW) end
	adc.read(0)
	conn:send("POST /".."path".." HTTP/1.1\r\nHost: "..host.."\r\nConnection: Keep-Alive\r\nAuthorization: \r\nContent-Type: application/json\r\n"..jsonparser({
    ["projectName"] = "hi",
    ["sensorModel"] = "TI000001",
    ["sensorType"]= "Thermal",
    ["unit"] = "Celcius",
    ["time"] = "2016-01-05",
    ["value"] = 110,
    ["lat"] = 0,
    ["lng"] = 0,
	["access_token"] = "16586e3d75a12ea0c560ed5045ee9af1"
	}).."/r/n",)
	end
else
end
end