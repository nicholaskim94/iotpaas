local data = {
    ["projectName"] = "hi",
    ["sensorModel"] = "TI000001",
    ["sensorType"]= "Thermal",
    ["unit"] = "Celcius",
    ["time"] = "2016-01-05",
    ["value"] = 110,
    ["lat"] = 0,
    ["lng"] = 0,
	["access_token"] = "16586e3d75a12ea0c560ed5045ee9af1"
	}
local host, url, reqtype = node.chipid(), "http://tranquil-sands-4879.herokuapp.com/api/v1/projects/hi", true
--choose normal parser for get or post, jsonparser for post
function normalparser(t) local result = "" for k,v in pairs(t) do result = result.."&"..k.."="..v end return string.sub(result, 2) end
function jsonparser(t) local result = "{" for k,v in pairs(t) do result = result..'"'..k..'":"'..v..'",' end return string.sub(result,0,-2)..'}' end
function PostRequest(host, path, data)
    return "POST /"..path.." HTTP/1.1\r\n"..
      "Host: "..host.."\r\n"..
      "Connection: Keep-Alive\r\n"..
	  "Authorization: \r\n"..
      "Content-Type: applicat-ion/json\r\n"..jsonparser(data).."/r/n"
end
function GetRequest(host, path, data)
    return "GET /"..path.."?"..normalparser(data).." HTTP/1.1\r\n"..
      "Host: "..host.."\r\n"..
      "Connection: Keep-Alive\r\n"..
	  "Authorization: \r\n"..
      "Content-Type: application/x-www-form-urlencoded\r\n\r\n"
end
print ("domain: "..url:match("[%w]*%.(.*%w+%.%w+)%/.*").."\npath: "..url:match("[%w]*%..*%w+%.%w+%/(.*)"))
conn=net.createConnection(net.TCP, 0) 
conn:on("receive", function(sck, pl) print(pl) end)
conn:dns(url:match("[%w]*%..*%w+%.%w+%/(.*)"),function(conn,ip) print(ip) end)
conn:connect(80, "tranquil-sands-4879.herokuapp.com") --parse domain from url
if reqtype then
conn:send(PostRequest(node.chipid(),url:match("[%w]*%..*%w+%.%w+%/(.*)"),data))
else
conn:send(GetRequest(node.chipid(),url:match("[%w]*%..*%w+%.%w+%/(.*)"),data))
end
