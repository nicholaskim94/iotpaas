function urlparser(t) local result = "" for k,v in pairs(t) do result = result.."&"..k.."="..v end 
	ContentLength = (string.len(result) - 1) 
	return string.sub(result, 2) 
end
function jsonparser(t) local result = "{" for k,v in pairs(t) do result = result..'"'..k..'":"'..v..'",' end 
	ContentLength = (string.len(result)) 
	return (string.sub(result,0,-2)..'}') 
end
function selparser(sel, data) if (sel == "json") then return jsonparser(data) elseif (sel == "url") then return urlparser(data) else print ("EncodeType Error") end end
function RequestBody(path, data)
	local body = selparser(EncodeType ,data)
	print ("ContentLength: "..ContentLength)
    return ReqType.." "..path.." HTTP/1.1\r\n"..
      Header().."\r\n"..body.."\r\n"
end
conn=net.createConnection(net.TCP, SECURITY) 
conn:on("receive", function(sck, pl) print (pl) end)
conn:connect(PORT, IP)
conn:send(RequestBody(Path,DataContainer))
print (RequestBody(Path,DataContainer))