local RiversideAPIKey = _G.Daemen.Settings.RiversideAPIKey
local firstToUpper = _G.Daemen.Functions.firstToUpper
AddCommand("riversidestatus", function(msg, args)
	local colours = {
		[false] = discordia.Color.fromRGB(212, 4, 4).value,
		[true] = discordia.Color.fromRGB(0, 156, 29).value
	}
	-- Bindings for the Riverside API
	coroutine.wrap(function()
		local res, body = http.request("GET", string.format("https://api.riverside-roleplay.com/status?token=%s", RiversideAPIKey))
		if body then
			body = json.decode(body)
			local embeds = {}
			for servername, gameserver in pairs(body) do
				if servername == "policerp" or servername == "jailbreak" then
					msg:reply {
						embed = {
							title = firstToUpper(servername):gsub("rp", "RP"),

							fields = {
								{name = "Server Name", value = gameserver['name'], inline = false},
								{name = "Server IP", value = gameserver['ipaddress'], inline = false},
								{name = "Server Map", value = gameserver['map'], inline = false},
								{name = "Server Gamemode", value = gameserver['gamemode'], inline = false},
							},

							color = colours[gameserver["status"]],
							timestamp = discordia.Date():toISO('T', 'Z')
						}
					}
				end
			end
		end 
	end)()
	
end, 0)