local function kill(client, logger, message, text)
    print('kill command received')
    if message.author.id == client.owner.id then
        message:reply('Aww dammit...')
        client:setStatus('invisible')
        client:stop()
    else
        message:reply("Fuck you. You don't own me.")
    end
end

local function reboot(client, logger, message, text)
    print('reboot command received')
    if message.author.id == client.owner.id then
        message:reply('Rebooting')
        client:stop()
        os.execute('reboot.bat')
    else
        message:reply("No thanks. I think I'm good.")
    end
end

return {
    kill = kill,
    reboot = reboot,
}