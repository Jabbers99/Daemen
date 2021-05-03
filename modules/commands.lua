local commandsPrefix = "./commands/"
local fs = _G.Daemen.Deps.FS
for _, file in pairs(fs.readdirSync(commandsPrefix)) do
	local filename = file:match("(%w+)%.lua")
	local code = fs.readFileSync(commandsPrefix..file)
	
	local sandbox = setmetatable({
		AddCommand = _G.Daemen.Functions.AddCommand,
		discordia = _G.Daemen.Discordia,
		Timer 		= _G.Daemen.Deps.Timer,
		http 			= _G.Daemen.Deps.HTTP,
		json 			= _G.Daemen.Deps.JSON,
		fs 			= fs
	}, { __index = _G })
	local fn, syntaxError = load(code, 'Daemen.Command.'..filename, 't', sandbox)
	if not fn then return print(syntaxError) end -- handle syntax errors

    local success, runtimeError = pcall(fn) -- run the code
    if not success then return print(runtimeError) end -- handle runtime errors
end