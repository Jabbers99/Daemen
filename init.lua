local discordia = require('discordia')
local client = discordia.Client()


client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

print("test")

client:run('Bot '..settings.token)