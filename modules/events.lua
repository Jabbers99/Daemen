local client = _G.Daemen.Client
local commands = _G.Daemen.Commands
-- Load helper extensions
_G.Daemen.Discordia.extensions()

client:on("messageCreate", function(msg)
    -- Setup commands
    local content = msg.content:lower()
    local args = content:split(" ")
    if (commands[args[1]] and commands[args[1]][2]) or (commands[content] and not commands[content][2]) then
        local output = commands[content][1](msg)
        if output then
            msg:reply(output)
        end
    end
end)