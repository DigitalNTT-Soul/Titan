local function lazarus(client, logger, message, text)
    local timer = require('timer')
    message:reply("RUUUUUUUU-huhuhuuuuuuuuun!!!")
    timer.sleep(300000)
    message:reply('It occurs to me that ' .. message.author.name .. ' was just fucking with me when he mentioned my worst nightmare... He\'ll pay for that later.')
end

local function notbadforasorceror(client, logger, message, text)
    message:reply("Fuck you, Angus.")
end

local function unnaturallust(client, logger, message, text)
    message:reply('https://i.pinimg.com/564x/4f/d8/85/4fd885bdf89eb6d6df576359466155cf.jpg')
end

return {
    lazarus = lazarus,
    notbadforasorceror = notbadforasorceror,
    unnaturallust = unnaturallust,
    }