POST = true
GET = false
local SSID = "SSID" --Put Your Wifi SSID on Here!
local Pass = "PASSWORD" --Put Your Wifi Password on Here!
local Timeout = Nil --Connection Closed after Timour, Put Nil to Run 'connect_wifi.lua' until Wifi Connected!
ConnectWifi = assert(loadfile("connect_wifi.lua"))
pcall(ConnectWifi, SSID, Pass, Timeout)
