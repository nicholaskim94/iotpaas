local SSID = "1208" --Put Your Wifi SSID on Here!
local Pass = "47984810" --Put Your Wifi Password on Here!
local Timeout = Nil --Connection Closed after Timour, Put Nil to Run 'connect_wifi.lua' until Wifi Connected!
ConnectWifi = assert(loadfile("connect_wifi.lua"))
pcall(ConnectWifi, SSID, Pass, Timeout)
