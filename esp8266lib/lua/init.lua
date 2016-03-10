dofile("Config.lua")
local ConnectWifi = assert(loadfile("ConnectWifi.lua"), "Loading ConnectWifi.lua failed")
pcall(ConnectWifi)