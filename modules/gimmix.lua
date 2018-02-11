local function lazarus(client, core, message)
    local timer = require('timer')
    local internalStatus = nil
    local bot = nil
    if message.guld then bot = message.guild:getMember(client.user) end
    if bot and bot.status~='invisble' then
        print('going offline')
        internalStatus = 'invisible'
        client:setStatus('invisible')
    end
    message:reply("RUUUUUUUU-huhuhuuuuuuuuun!!!")
    timer.sleep(30000)
    if internalStatus == 'invisible' then
        print('coming online')
        client:setStatus('online')
    end
    return message:reply('It occurs to me that ' .. message.author.name .. ' was just fucking with me when he mentioned my worst nightmare... He\'ll pay for that later.')
end

local function notbadforasorceror(client, core, message)
    return message:reply("Fuck you, Angus...")
end

local function unnaturallust(client, core, message)
    return message:reply('https://i.pinimg.com/564x/4f/d8/85/4fd885bdf89eb6d6df576359466155cf.jpg')
end

local function fuckthisgame(client, core, message)
    if message._text ~= '' then
        return message:reply('(╯°□°）╯︵ ┻━┻\n***__'.. message._text:upper() .. '__***')
    else
        return message:reply('(╯°□°）╯︵ ┻━┻')
    end
end

return {
    lazarus = lazarus,
    notbadforasorceror = notbadforasorceror,
    unnaturallust = unnaturallust,
    fuckthisgame = fuckthisgame,
    }