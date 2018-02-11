local function kill(client, core, message)
    local logger = client._logger
    if message.author.id == client.owner.id then
        logger:log(3 --[[info]], message.author.fullname .. ' called kill.')
        message:reply('Aww dammit...')
        client:setStatus('invisible')
        return client:stop()
    else
        logger:log(2 --[[warning]], message.author.fullname .. ' does not have license to kill!')
        return message:reply("fuck you. You don't own me.")
    end
end

local function reboot(client, core, message)
    local logger = client._logger
    if message.author.id == client.owner.id then
        logger:log(3 --[[info]], message.author.id .. ' called reboot.')
        message:reply('Rebooting')
        return client._reboot(core)
    else
        logger:log(2 --[[warning]], message.author.fullname .. ' does not have license to reboot!')
        return message:reply("No thanks. I think I'm good.")
    end
end

local function exec(client, core, message)
    local sandbox = setmetatable({
        require = require,
        client = client,
        logger = client._logger,
        message = message,
        text = message._text,
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

    local fn, syntaxError = load(message._text, 'exec' ,'t', sandbox)
    if not fn then return message:reply(code(syntaxError)) end

    local success, result = pcall(fn)
    if not success then return message:reply(code(result)) end
    local response = tostring(result)
    if response and #response <= 1993 then
        return message:reply(code(response))
    elseif response and #response > 1993 then
        for i=0, math.ceil(#response/1990)-1 do
            local low = 1 + (1990 * i)
            local high = 1990 + (1990 * i)
            if high >= #response then
                high = #response
                return message:reply(code(response:sub(low, high)))
            end
            message:reply(code(response:sub(low,high) .. "..."))
        end
        return
    elseif not response then
        return message:reply(code('nil? Was that supposed to happen?'))
    end
end

return {
    kill = kill,
    reboot = reboot,
    exec = exec,
}