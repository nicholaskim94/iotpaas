local arg = {...}
print(arg[1])
file.open("data.txt", "a+")
file.writeline(arg[1]..",TQWQR1"..",TEMP"..",Cellcius,".."0")
--file.flush()
print("Sensor Information Added")
file.close()

--data["time"]
--data["sensorModel"]
--data["sensorType"]
--data["unit"]
--data["value"] 
