function urlparser(t) local result = "" for k,v in pairs(t) do result = result.."&"..k.."="..v end return string.sub(result, 2) end
function jsonparser(t) local result = "{" for k,v in pairs(t) do result = result..'"'..k..'":"'..v..'",' end return (string.sub(result,0,-2)..'}') end
function PostRequest(path, data)
	print (jsonparser(data))
    return "POST /"..path.." HTTP/1.1\r\n"..
      Header..jsonparser(data).."/r/n/r/n"
end
function GetRequest(path, data)
    return "GET /"..path.."?"..urlparser(data).." HTTP/1.1\r\n"..Header.."/r/n"
end
conn=net.createConnection(net.TCP, 0) 
conn:on("receive", function(sck, pl) end)
conn:connect(80, IP)
if ReqType == "POST" then
	conn:send(PostRequest(Path,DataContainer))
elseif ReqType == "GET" then
	conn:send(GetRequest(Path,DataContainer))
else
	print ("ReqType error")
end
