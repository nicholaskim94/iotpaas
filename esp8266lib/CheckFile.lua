local tmp
local Line
if (file.open("data.txt", "r")) then
    Line = file.readline()
else
    Line = false
end
while Line do
    local ptmp
    ptmp = Line.find(Line, ",")
    DataContainer["time"] = Line:sub(1, ptmp - 1)
    Line = Line.sub(Line, ptmp + 1)
    ptmp = Line.find(Line, ",")
    DataContainer["sensorModel"] = Line:sub(1, ptmp - 1)
    Line = Line.sub(Line, ptmp + 1)
    ptmp = Line.find(Line, ",")
    DataContainer["sensorType"] = Line:sub(1, ptmp - 1)
    Line = Line.sub(Line, ptmp + 1)
    ptmp = Line.find(Line, ",")
    DataContainer["unit"] = Line:sub(1, ptmp - 1)
    Line = Line.sub(Line, ptmp + 1)
    DataContainer["value"] = Line
    if wifi.sta.getip() ~= nil then
        dofile ("Request.lua")
        Line = file.readline()
    else
        print("Internet Connection Lost")
        tmp = file.read()
        if (tmp) then
            file.wirte(tmp)
        else
            file.close()
            file.remove("data.txt")
        end
        break
    end
end
file.close()