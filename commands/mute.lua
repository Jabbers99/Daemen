AddCommand("mute", function(msg, args)
	args[1] = nil
	
	if not args[#args]:match('<@!?(%d+)>') then reason = args[#args] end

	local membersToMute = _G.Daemen.Functions.FindMentions(args)
	for _, m in pairs(membersToMute) do
		local mem = msg.guild:getMember(m)
		mem:AddRole(mutedRole)
		msg.channel:sendf("Muting member `%s`", _G.Daemen.Functions.MakeSafe(mem.tag))

	end

end, 5)
