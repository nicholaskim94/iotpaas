--set 8channel Mux as output
local Request = assert(loadfile("Request.lua"), "Loading Request.lua failed")
--set lag and lan here
function split(pString, pPattern)
   local Table = {} 
   local fpat = "(.-)" .. pPattern
   local last_end = 1
   local s, e, cap = pString:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	  table.insert(Table,cap)
      end
      last_end = e+1
      s, e, cap = pString:find(fpat, last_end)
   end
   if last_end <= #pString then
      cap = pString:sub(last_end)
      table.insert(Table, cap)
   end
   return Table
end
tmr.alarm(0, UploadInterval, 1, function()
	dofile ("GetTimeToMux.lua")
	local tmp
	if (file.open("data.txt", "w"))	then
		file.seek("set")
		local Line = file.readline()
	else
		Line = false
	end
	while Line do
		print ("Line Readed From data.txt: "..Line)
		DataContainer["time"],DataContainer["sensorModel"],DataContainer["sensorType"],DataContainer["unit"],DataContainer["value"] = split(Line, ",")
		if wifi.sta.getip() ~= nil then
			print (DataContainer)
			pcall (Request, DataContainerContainer)
			Line = file.readline()
		else
			print("Internet Connection Lost")
			break
		end
	end
	tmp = file.read()
	if (tmp) then
		file.wirte(tmp)
	else
		file.remove("data.txt")
	end
	file.close()
end)
