conn=net.createConnection(net.TCP, 0) 
conn:on("connection",function(conn)
conn:send("HEAD / HTTP/1.1\r\n".. 
          "Host: google.com\r\n"..
          "Accept: */*\r\n"..
          "User-Agent: Mozilla/4.0 (compatible; esp8266 Lua;)"..
          "\r\n\r\n") 
end)            
conn:on("receive", function(conn, payload)
	local Time
	Time = string.sub(payload,string.find(payload,"Date: ")+11,string.find(payload,"Date: ")+35)
	print ("Time: "..Time)
	conn:close()
    for i = 1, NumberOfData do
    	local Module = require (DataModuleArray[i])
    	local Value = Module.GetValue()
    	print ("Loaded Module: "..DataModuleArray[i])
    	--local Module = assert(loadfile(DataModuleArray[i]), "Loading "..DataModuleArray[i].." failed")
    	file.open("data.txt", "a+")
		file.writeline(Time..","..Module.SensorModel()..","..Module.SensorType()..","..Module.Unit()..","..Value)
		print ("value: "..Value)
    end
	file.seek("set")
	print (file.read())
    file.close()
    print("Sensor Information Added")
    return nil
end)     
conn:connect(80,'google.com')