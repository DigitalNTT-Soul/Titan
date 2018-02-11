discordia.extensions()
local logger = client._logger

local function dm(client, core, message)
    if message.guild then
        local discordia = require('discordia')
        local file = io.open('./database/DMs/' .. message.guild.id, 'r')
        local record = {}
        if file then
            record = file:read('*a'):split('\n')
            file:close()
        end
        local mention = message.mentionedUsers:toArray()
        local currentDm
        if #record==2 then
            currentDm = message.guild:getMember(record[2])
            if not currentDm then logger:log(1 --[[error]], "^^dm.dm: Guild File corrupted. Coult not obtain Member object.^^") end
        end
        if #mention == 1 then
            local mentioned = message.guild:getMember(mention[1])
            if mentioned:hasPermission(0x00000008) then
                if currentDm and record[1]=='1' then
                    return message:reply(currentDm.name .. " is the permanent DM for this server. If you feel this is in error, reroll a bard and cry for attention.")
                elseif not currentDm or record[1]~='1' or #record~=2 then
                    file = io.open('./database/DMs/' .. message.guild.id, 'w')
                    file:write('0\n' .. mentioned.id)
                    file:close()
                    return message:reply(mentioned.name .. " successfully set as this server's current DM.")
                end
            else
                return message:reply(mentioned.name .. ' does not have admin permissions, and cannot be granted DM powers.')
            end
        elseif #mention == 0 then
            if currentDm and record[1]=='1' then
                return message:reply(currentDm.name .. " is the permanent DM for this server. If you feel this is in error, reroll a bard and cry for attention.")
            elseif currentDm and record[1]=='0' then
                return message:reply(currentDm.name .. " is currently the DM. If you were trying to change that, RTFM.")
            else
                return message:reply("Try again, but this time, tell me who it's supposed to be.")
            end
        elseif #mention > 1 then
            return message:reply('Whoa, now. Multiple dungeon masters is ***__NOT__*** as kinky as you might think.')
        else
            logger:log(1 --[[error]], "DM-1: Unexpected number of mentioned users.")
            return message:reply('Error dm-1: "The number of mentioned users was negative or not an integer. wtf discord -_-."\n' .. client.owner.mentionString)
        end
    else
        return message:reply("If you want a private roleplay with me, ***I'm*** the dungeon master :wink:.")
    end
end

local function pdm(client, core, message)
    if message.guild then
        if message.author.id == message.guild.ownerId then
            guildDmRecord = io.open('./database/DMs/' .. message.guild.id, 'w')
            guildDmRecord:write('1\n' .. message.author.id)
            guildDmRecord:close()
            return message:reply('***__ALL HAIL OUR LORD AND DAMNATION, ' .. message. author.name:upper() .. "!!!__***")
        else
            return message:reply('You attempt to cast the Divine Spell of Godly Ascension...\n\nand then you remember you have no power here...')
        end
    else
        return message:reply("If you want a private roleplay with me, ***I'm*** the dungeon master :wink:.")
    end
end

local function spam(client, core, message)
    local function loop(channel, text)
        for i=1, 5 do
            channel:send(text)
        end
        return
    end

    text = message._text
    if message.guild then
        if message.guild:getMember(message.author):hasPermission(0x00000008) then
            if text~='' then
                if message.guild:getMember(client.user):hasPermission(0x00000010) then
                    spamChannel = message.guild:createTextChannel('Spamming')
                    loop(spamChannel, text)
                    return spamChannel:delete()
                else
                    return loop(message.channel, text)
                end
            else
                return message:reply('Try again, but this time, tell me what to FUCKING SAY!!!')
            end
        else
            return message:reply("You don't have that authority here, noob.")
        end
    else
        if text~='' then
            return loop(message.channel, text)
        else
            return message:reply("Try again, but this time tell me what to FUCKING SAY!!!")
        end
    end
end

return {
    dm = dm,
    pdm = pdm,
    spam = spam,
    }