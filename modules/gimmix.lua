local function lazarus(client, core, message)
    if message.author.id ~= '254455986973179906' then
        local timer = require('timer')
        
        message:reply("RUUUUUUUU-huhuhuuuuuuuuun!!!")
        timer.sleep(30000)
        return message:reply('It occurs to me that ' .. message.author.name .. ' was just fucking with me when he mentioned my worst nightmare... He\'ll pay for that later.')
    else
        return message:reply("You are he who fucks with time. I am he who fucks with You.")
    end
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

local function damnitconor(client, core, message)
    if message.author.id ~= "305091651129573386" then
        return message:reply("https://cdn.discordapp.com/attachments/280096809462792194/414964824594841600/h33cZarnmfAAAAABJRU5ErkJggg.png")
    end
end

return {
    lazarus = lazarus,
    notbadforasorceror = notbadforasorceror,
    unnaturallust = unnaturallust,
    fuckthisgame = fuckthisgame,
    damnitconor = damnitconor,
    }