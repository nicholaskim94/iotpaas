function urlparser(t) local result = "" for k,v in pairs(t) do result = result.."&"..k.."="..v end return string.sub(result, 2) end
function jsonparser(t) local result = "{" for k,v in pairs(t) do result = result..'"'..k..'":"'..v..'",' end return (string.sub(result,0,-2)..'}') end
function selparser(sel, data) if (sel == "json") then return jsonparser(data) elseif (sel == "url") then return urlparser(data) else print ("EncodeType Error") end end
function PostRequest(path, data)
    return "POST /"..path.." HTTP/1.1\r\n"..
      Header..selparser(EncodeType ,data).."\r\n\r\n"
end
function GetRequest(path, data)
    return "GET /"..path.."?"..selparser(data).." HTTP/1.1\r\n"..Header.."\r\n"
end
conn=net.createConnection(net.TCP, SECURITY) 
conn:on("receive", function(sck, pl) print (pl) end)
conn:connect(PORT, IP)
if ReqType == "POST" then
	conn:send(PostRequest(Path,DataContainer))
elseif ReqType == "GET" then
	conn:send(GetRequest(Path,DataContainer))
else
	print ("ReqType error")
end