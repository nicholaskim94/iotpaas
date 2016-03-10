--choose normal parser for get or post, jsonparser for post
function normalparser(t) local result = "" for k,v in pairs(t) do result = result.."&"..k.."="..v end return string.sub(result, 2) end
function jsonparser(t) local result = "{" for k,v in pairs(t) do result = result..'"'..k..'":"'..v..'",' end return string.sub(result,0,-2)..'}' end
function PostRequest(Host, path, data)
    return "POST /"..path.." HTTP/1.1\r\n"..
      Header..jsonparser(data).."/r/n/r/n"
end
function GetRequest(Host, path, data)
    return "GET /"..path.."?"..normalparser(data).." HTTP/1.1\r\n"..Header.."/r/n"
end
print ("domain: "..Url:match("[%w]*%.(.*%w+%.%w+)%/.*").."\npath: "..Url:match("[%w]*%..*%w+%.%w+%/(.*)"))
conn=net.createConnection(net.TCP, 0) 
conn:on("receive", function(sck, pl) print(pl) end)
conn:dns(Url:match("[%w]*%..*%w+%.%w+%/(.*)"),function(conn,ip) print(ip) end)
conn:connect(80, Url:match("[%w]*%.(.*%w+%.%w+)%/.*")) --parse domain from Url
if ReqType == "POST" then
conn:send(PostRequest(node.chipid(),Url:match("[%w]*%..*%w+%.%w+%/(.*)"),data))
else
conn:send(GetRequest(node.chipid(),Url:match("[%w]*%..*%w+%.%w+%/(.*)"),data))
end