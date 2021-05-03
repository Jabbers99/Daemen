local client = _G.Daemen.Client
local commands = _G.Daemen.Commands
local fs = _G.Daemen.Deps.FS
-- Load helper extensions
_G.Daemen.Discordia.extensions()
client:on("ready", function()

    print(client.user.id)
end)
client:on("messageCreate", function(msg)

end)
local eventsPrefix = "./events/"
for _, file in pairs(fs.readdirSync(eventsPrefix)) do
    local filename = file:match("(%w+)%.lua")
    local code = fs.readFileSync(eventsPrefix..file)



    client:on(filename, function(...)
        local sandbox = setmetatable({..., commands = commands}, { __index = _G })

        local fn, syntaxError = load(code, 'Daemen.Event.'..filename, 't', sandbox)
        if not fn then return print(syntaxError) end -- handle syntax errors
        
        local success, runtimeError = pcall(fn, ...) -- run the code
        if not success then return print(runtimeError) end -- handle runtime errors      
    end)

end