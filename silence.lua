local config = require('./config.lua')
local discordia = require('discordia')
local client = discordia.Client()
local sPrefix = config[6]
local name = config[5]:lower()

client:on('messageCreate', function (message)
    if message.author.id == client.owner.id and message.content:lower() == sPrefix .. name then
        message:reply('``SILENCE`` Safe Rebooting. Stand By.')
        os.execute('boot.bat')
    end
end)

client:run('Bot ' .. config[1])