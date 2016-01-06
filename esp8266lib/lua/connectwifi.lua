print("set up wifi mode\n")
local arg = {...}
wifi.setmode(wifi.STATION)
wifi.sta.config(arg[1], arg[2])
if arg[3] then tmr.alarm(2,arg[3],0,function() 
tmr.stop(1)
wifi.sta.disconnect()
print ("ConnectionTimeout. Restarting the Chip\n")
NODE.RESTART()
return ("ConnectionTimeout\n")
end)
else print ("Function Called Without Timeout.\n") 
end
print("Connecting to SSID: "..arg[1].." Password: "..arg[2].."\n")
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function() 
    if wifi.sta.getip()== nil then 
    	print("Connecting...\n")
		wifi.sta.connect()
	else 
    	tmr.stop(1)
		tmr.stop(2)
    	print ("Connection Complete, IP is \n"..wifi.sta.getip())
		dofile ("datatoserver.lua")
		return ("ConnectionSuccessful")
    end
 end)
 