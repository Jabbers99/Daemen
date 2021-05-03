
-- Setup commands
local msg = select(1, ...)
local content = msg.content:lower()
local args = content:split(" ")
local cmd = (commands[args[1]] and commands[args[1]][2] and args[1]) or (commands[content] and not commands[content][2] and content) or false
if cmd then
	if commands[cmd][2] then
		if #args ~= commands[cmd][2] + 1 and (commands[cmd][2] ~= 0 or #args == 1) then
			print(commands[cmd][2], #args)
			msg:reply("Insufficient arguments!")
			return
		end
	end
	local cmdid = cmd:sub(2)
	if _G.Daemen.Permissions[cmdid] then
		local member = msg.guild:getMember(msg.author.id)
		for _, perm in pairs(_G.Daemen.Permissions[cmdid]) do
			if not member:hasPermission(perm) then msg:reply("You don't seem to have permissions for that!") return end
		end
	end
    local output = commands[cmd][1](msg, args)
    if output then
        msg:reply(output)
    end
end