local config = require('./config.lua')
local discordia = require('discordia')
local client = discordia.Client()
local prefix = config[6]

client:on('messageCreate', function (message)
    if message.author.id == client.owner.id and message.content == prefix .. 'titan' then
        message:reply('``TITAN`` Safe Rebooting. Stand By.')
        os.execute('boot.bat')
    end
end)

client:run('Bot ' .. config[1])