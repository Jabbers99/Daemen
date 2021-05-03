local discordia = _G.Daemen.Discordia
local AddCommand = _G.Daemen.Functions.AddCommand
local Timer = _G.Daemen.Deps.Timer
local http = _G.Daemen.Deps.HTTP
local json = _G.Daemen.Deps.JSON
AddCommand("ping", function(msg) return "Pong!" end)
AddCommand("kick", function(msg, args) 
	args[1] = nil
	
	local reason = ""
	if not args[#args]:match('<@!?(%d+)>') then reason = args[#args] end

	local membersToKick = _G.Daemen.Functions.FindMentions(args)
	for _, m in pairs(membersToKick) do
		local mem = msg.guild:getMember(m)
		--mem:Kick(reason)
		if reason == "" then
			msg.channel:sendf("Kicking member `%s`", _G.Daemen.Functions.MakeSafe(mem.tag))
		else 
			msg.channel:sendf("Kicking member `%s` for reason `%s`", _G.Daemen.Functions.MakeSafe(mem.tag), _G.Daemen.Functions.MakeSafe(reason))
		end

	end
end, 5)
AddCommand("ban", function(msg, args)
	args[1] = nil
	
	local reason = ""
	if not args[#args]:match('<@!?(%d+)>') then reason = args[#args] end

	local membersToBan = _G.Daemen.Functions.FindMentions(args)
	for _, m in pairs(membersToBan) do
		local mem = msg.guild:getMember(m)
		--mem:Ban(reason)
		if reason == "" then
			msg.channel:sendf("Banning member `%s`", _G.Daemen.Functions.MakeSafe(mem.tag))
		else 
			msg.channel:sendf("Banning member `%s` for reason `%s`", _G.Daemen.Functions.MakeSafe(mem.tag), _G.Daemen.Functions.MakeSafe(reason))
		end

	end
end, 5)
AddCommand("mute", function(msg, args)
	args[1] = nil
	
	if not args[#args]:match('<@!?(%d+)>') then reason = args[#args] end

	local membersToMute = _G.Daemen.Functions.FindMentions(args)
	for _, m in pairs(membersToMute) do
		local mem = msg.guild:getMember(m)
		--mem:AddRole(mutedRole)
		msg.channel:sendf("Muting member `%s`", _G.Daemen.Functions.MakeSafe(mem.tag))

	end

end, 5)
AddCommand("remind", function(msg, args)
	local multipliers = {["second"] = 1000, ["minute"] = "60000", ["hour"] = "3600000", ["day"] = "86400000"}
	
	args[1] = nil

	local reminder = _G.Daemen.Functions.MakeSafe(table.concat(args, " ", 3))
	if not args[2] or not reminder then return end

	local delay, humanTime = args[2]:match("(%d+)(%a+)")
	
	
	-- Parse time	
	local unit = _G.Daemen.Functions.ParseHumanTime(humanTime)
	if not unit then return end
	
	-- Set the reminder
	delay = delay*multipliers[unit]
	local chnl = msg.channel
	if not _G.Daemen.Reminders[msg.author.id] or _G.Daemen.Reminders[msg.author.id] < 3 then
		_G.Daemen.Reminders[msg.author.id] = 0
		Timer.setTimeout(delay, function()
			coroutine.wrap(function() chnl:sendf("%s %s milliseconds ago, you asked me to remind you about `%s`", msg.author.mentionString, delay, reminder) end)()
			_G.Daemen.Reminders[msg.author.id] = _G.Daemen.Reminders[msg.author.id] + 1
			if _G.Daemen.Reminders[msg.author.id] >= 3 then _G.Daemen.Reminders[msg.author.id] = nil end
		end)
	else
		msg:reply("You already have three set reminders: "..reminder)
	end
end, 0)
local RiversideAPIKey = _G.Daemen.Settings.RiversideAPIKey
local firstToUpper = _G.Daemen.Functions.firstToUpper
AddCommand("riversidestatus", function(msg, args)
	local colours = {
		[false] = discordia.Color.fromRGB(212, 4, 4).value,
		[true] = discordia.Color.fromRGB(0, 156, 29).value
	}
	-- Bindings for the Riverside API
	coroutine.wrap(function()
		local res, body = HTTP.request("GET", string.format("https://api.riverside-roleplay.com/status?token=%s", RiversideAPIKey))
		if body then
			body = JSON.decode(body)
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