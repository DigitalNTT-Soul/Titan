local function kill(client, logger, message, text)
    if message.author.id == client.owner.id then
        logger:log(3 --[[info]], message.author.fullname .. ' called kill.')
        message:reply('Aww dammit...')
        client:setStatus('invisible')
        return client:stop()
    else
        logger:log(2 --[[warning]], message.author.fullname .. ' does not have permission to kill!')
        return message:reply("Fuck you. You don't own me.")
    end
end

local function reboot(client, logger, message, text)
    if message.author.id == client.owner.id then
        logger:log(3 --[[info]], message.author.fullname .. ' called reboot.')
        message:reply('Rebooting')
        client:setStatus('invisible')
        client:stop()
        return os.execute('boot.bat')
    else
        logger:log(2 --[[warning]], message.author.fullname .. ' does not have permission to reboot!')
        return message:reply("No thanks. I think I'm good.")
    end
end

local function exec(client, logger, message, text)
	local sandbox = setmetatable({
		client = client,
		logger = logger,
		message = message,
		text = text,
	}, { __index = _G })
    local function code(str)
        return string.format('```\n%s```', str)
    end
    if message.author.id ~= client.owner.id then
		return message:reply("YOU'RE NOT MY REAL DAD!!!")
	end
	if text == '' then
		return message:reply('Executing nothing... result: boredom.')
	end
	local fn, syntaxError = load(text, 'Titan', 't', sandbox)
	if not fn then
		return message:reply(code(syntaxError))
	end

	local success, runtimeError = pcall(fn)
    if success then
        local response = assert(fn)()
        if response then response = tostring(response) end
        if response and #response <= 1993 then
            return message:reply(code(response))
        elseif response and #response > 1993 then
            return message:reply(code(response:sub(1,1990) .. "..."))
        elseif not response then
            return message:reply('Uh... Error? Fix your shit, boss.')
        end
	end
	if not success then
		return message:reply(code(runtimeError))
	end
end

return {
    kill = kill,
    reboot = reboot,
    exec = exec,
}