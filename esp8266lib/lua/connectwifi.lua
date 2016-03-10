print("set up wifi mode\n")
require "LocationInit"
wifi.setmode(wifi.STATION)
wifi.sta.config(SSID, Pass)
if TimeOut then tmr.alarm(2,arg[3],0,function() 
tmr.stop(1)
wifi.sta.disconnect()
print ("ConnectionTimeout. Restarting the Chip\n")
NODE.RESTART()
print ("ConnectionTimeout\n")
end)
else print ("Function Called Without Timeout.\n") 
end
print("Connecting to SSID: "..SSID.." Password: "..Pass.."\n")
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function() 
    if wifi.sta.getip()== nil then 
    	print("Connecting...\n")
		wifi.sta.connect()
	else 
    	tmr.stop(1)
		tmr.stop(2)
		print ("Connection Complete, IP is \n"..wifi.sta.getip())
		Location = LocationInit.GetLocation()
		local DTS = assert(loadfile("DataToServer.lua"), "Loading DataToServer failed")
		pcall(DTS)
		print ("ConnectionSuccessful")
		return
    end
 end)