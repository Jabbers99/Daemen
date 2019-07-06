local discordia = require('discordia')
local client = discordia.Client()

local settings = require('./settings.lua')

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
	if message.content == '!ping' then
		message.channel:send('Pong!')
	end
end)

client:run('Bot '..settings.token)