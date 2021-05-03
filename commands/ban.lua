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

