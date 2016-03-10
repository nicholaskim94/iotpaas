module('GetTime', package.seeall)
function GetTime()
  local Time
  conn=net.createConnection(net.TCP, 0) 
  conn:on("connection",function(conn)
  conn:send("HEAD / HTTP/1.1\r\n".. 
            "Host: google.com\r\n"..
            "Accept: */*\r\n"..
            "User-Agent: Mozilla/4.0 (compatible; esp8266 Lua;)"..
            "\r\n\r\n") 
  end)            
  conn:on("receive", function(conn, payload)
    Time = string.sub(payload,string.find(payload,"Date: ")+11,string.find(payload,"Date: ")+35)
    print ("Time: "..Time)
    conn:close()
    return Time
  end)     
  conn:connect(80,'google.com') 
end