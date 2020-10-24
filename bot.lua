local discordia = _G.Daemen.Discordia
local client = _G.Daemen.Client
local settings = _G.Daemen.Deps.Settings
client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)


client:run('Bot '..settings.Token)