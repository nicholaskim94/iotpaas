print("set up wifi mode\n")
wifi.setmode(wifi.STATION)
wifi.sta.config(SSID, Pass)
if TimeOut then 
	tmr.alarm(1,arg[3],0,function() 
		tmr.stop(0)
		wifi.sta.disconnect()
		print ("ConnectionTimeout. Restarting the Chip\n")
		NODE.RESTART()
	end)
else print ("Function Called Without Timeout.\n") end
print("Connecting to SSID: "..SSID.." Password: "..Pass.."\n")
wifi.sta.connect()
tmr.alarm(0, 1000, 1, function()
    if wifi.sta.getip() == nil then 
    	print("Connecting...\n")
		wifi.sta.connect()
	else 
    	tmr.stop(0)
		tmr.stop(1)
		print ("Connection Complete, IP is \n"..wifi.sta.getip())
		dofile ("LocationInit.lua")
		local DTS = assert(loadfile("DataToServer.lua"), "Loading DataToServer failed")
		pcall(DTS)
		print ("ConnectionSuccessful")
    end
 end)