AddCommand("joke", function(msg, args)
	table.remove(args, 1)
	local categoryOptions = {
		miscellaneous = true,
		misc = true,
		programming = true,
		dark = true,
		pun = true,
		spooky = true,
		christmas = true
	}

	for i, v in ipairs(args) do
		args[i] = v:gsub("%p", "")
		if not categoryOptions[args[i]:lower()] then return "Invalid category!" end
	end
	local categories = {"Miscellaneous", "Dark"}
	if #args > 0 then
		categories = args
	end

	local res, body = http.request("GET", "https://sv443.net/jokeapi/v2/joke/"..table.concat(categories, ","))
	body = json.decode(body)

	msg:reply(body.setup)
	
	Timer.setTimeout(1500, function()
		coroutine.wrap(function()
			msg:reply(body.delivery)
		end)()
	end)
	

end, 0)
