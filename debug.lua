local function kill(client, logger, message, text)
    print('kill command received')
    if message.author.id == client.owner.id then
        message:reply('Aww dammit...')
        client:setStatus('invisible')
        client:stop()
    else
        message:reply('Fuck you.')
    end
end

local function reboot(client, logger, message, text)
    --intended to clear all TITAN modules and reload them
end

return {
    kill = kill,
}