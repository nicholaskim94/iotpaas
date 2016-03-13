local tmp
local Line
if (file.open("data.txt", "r")) then
    Line = file.readline()
else
    Line = false
end
while Line do
    DataContainer["time"],DataContainer["sensorModel"],DataContainer["sensorType"],DataContainer["unit"],DataContainer["value"] = Line:match("(.*),(.*),(.*),(.*),(.*)")
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