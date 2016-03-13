conn=net.createConnection(net.TCP, 0) 
conn:on("connection",function(conn)
conn:send("HEAD / HTTP/1.1\r\n".. 
	"Host: google.com\r\n"..
	"Accept: */*\r\n"..
	"User-Agent: esp8266 Lua"..
	"\r\n\r\n") 
end)            
conn:on("receive", function(conn, payload)
	GoogleTime = string.sub(payload,string.find(payload,"Date: ")+11,string.find(payload,"Date: ")+35) -- Extract Time from response
	print ("Time: "..GoogleTime)
	conn:close()
	dofile ("DataCollectingLoop.lua")
end)     
conn:connect(80,'google.com')