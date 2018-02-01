local function kill(client, logger, message, text)
    if message.author.id == client.owner.id then
        logger:log(3 --[[info]], message.author.fullname .. ' called kill.')
        message:reply('Aww dammit...')
        client:setStatus('invisible')
        client:stop()
    else
        logger:log(2 --[[warning]], message.author.fullname .. ' does not have permission to kill!')
        message:reply("Fuck you. You don't own me.")
    end
end

local function reboot(client, logger, message, text)
    if message.author.id == client.owner.id then
        logger:log(3 --[[info]], message.author.fullname .. ' called reboot.')
        message:reply('Rebooting')
        client:setStatus('invisible')
        client:stop()
        os.execute('reboot.bat')
    else
        logger:log(2 --[[warning]], message.author.fullname .. ' does not have permission to reboot!')
        message:reply("No thanks. I think I'm good.")
    end
end

local function exec(client, logger, message, text)
    if message.author.id == client.owner.id then
        logger:log(3 --[[info]], message.author.fullname .. ' called exec.')
        script = loadstring(text)
        if pcall(assert(script)()) then
            message:reply(assert(script)())
        else
            message:reply('Uh... it errored...')
        end
        --pcall(message:reply(), assert(script)())
    else
        logger:log(2 --[[warning]], message.author.fullname .. ' does not have permission to reboot!')
        message:reply("YOU'RE NOT MY REAL DAD!!!")
    end
end

return {
    kill = kill,
    reboot = reboot,
    exec = exec,
}