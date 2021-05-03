AddCommand("avatar", function(msg, args)

	local user = msg.mentionedUsers.first
	if user then
		local footer = functions.GetDefaultFooter(msg.author)
		msg:reply({
			embed = {
				image = {
					url = user.avatarURL
				},
				footer = footer
			}
		})
	end
end, 1, {"pfp", "logo", "image"})
