local host, url, data, reqtype = ...
--choose normal parser for get or post, jsonparser for post
function normalparser(t) local result = "" for k,v in pairs(t) do result = result.."&"..k.."="..v end return string.sub(result, 2) end
function jsonparser(t) local result = "{" for k,v in pairs(t) do result = result..'"'..k..'":"'..v..'",' end return string.sub(result,0,-2)..'}' end
function PostRequest(host, path, data)
    return "POST /"..path.." HTTP/1.1\r\n"..
      "Host: "..host.."\r\n"..
      "Connection: Keep-Alive\r\n"..
	  "Authorization: \r\n"..
      "Content-Type: application/json\r\n"..jsonparser(data).."/r/n"
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
conn:connect(80, url:match("[%w]*%.(.*%w+%.%w+)%/.*")) --parse domain from url
if reqtype then
conn:send(PostRequest(node.chipid(),url:match("[%w]*%..*%w+%.%w+%/(.*)"),data))
else
conn:send(GetRequest(node.chipid(),url:match("[%w]*%..*%w+%.%w+%/(.*)"),data))
end