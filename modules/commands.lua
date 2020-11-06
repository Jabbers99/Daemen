local AddCommand = _G.Daemen.Functions.AddCommand

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
AddCommand("mute", function(msg)
	args[1] = nil
	
	if not args[#args]:match('<@!?(%d+)>') then reason = args[#args] end

	local membersToMute = _G.Daemen.Functions.FindMentions(args)
	for _, m in pairs(membersToMute) do
		local mem = msg.guild:getMember(m)
		--mem:AddRole(mutedRole)
		msg.channel:sendf("Muting member `%s`", _G.Daemen.Functions.MakeSafe(mem.tag))

	end

end, 5)