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
	local mentionString = msg.author.mentionString
	if not _G.Daemen.Reminders[msg.author.id] or _G.Daemen.Reminders[msg.author.id] < 3 then
		_G.Daemen.Reminders[msg.author.id] = 0
		Timer.setTimeout(delay, function()
			coroutine.wrap(function() chnl:sendf("%s %s milliseconds ago, you asked me to remind you about `%s`", msg.author.mentionString, tostring(math.floor(delay/60000)).."m", reminder) end)()
			_G.Daemen.Reminders[msg.author.id] = _G.Daemen.Reminders[msg.author.id] + 1
			if _G.Daemen.Reminders[msg.author.id] >= 3 then _G.Daemen.Reminders[msg.author.id] = nil end
		end)
		chnl:sendf("%s, in %s: `%s`, msg.mentionString, delay, reminder)
	else
		msg:reply("You already have three set reminders: "..reminder)
	end
end, 0)
