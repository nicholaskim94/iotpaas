module('LocationInit', package.seeall)
function GetLocation()
	conn=net.createConnection(net.TCP, 0) 
	conn:on("connection",function(conn)
	conn:send("HEAD /geolocation/v1/geolocate?key=AIzaSyDwIviNYoO8e3IKGGcfGlLtRAo6QKdVbPs HTTP/1.1\r\n\r\n") end)            
	conn:on("receive", function(conn, payload)
    Location = payload print("Location: "..Location) conn:close() end) 
	conn:connect(80,'google.com')
end