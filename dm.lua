local function dm(client, logger, message, text)
    if message.guild then --if the message was sent in a guild
        print('Found Guild ' .. message.guild.name .. message.guild.id)
        local guildDmRecord = io.open('./guilds/' .. message.guild.id, 'w')
        local line1 = guildDmRecord:read('*l')
        local line2 = guildDmRecord:read('*l')
        guildDmRecord:close()
        local mention = message.mentionedUsers:toArray()
        for i = 1, #mention do
            client.owner:send("dm.dm mention #" .. i .. ' ' .. mention[i].name)
        end
        if #mention == 1 and message.guild:getMember(mention[1]):hasPermission(0x00000008) then --true if 1 and ONLY 1 user was mentioned in 'message'
            print('one mention')
            if line1 == '1' then --true if the guild already has a permanent DM
                print('permanent DM')
                local currentDm = message.guild:getMember(line2).name
                message:reply(currentDm .. " is the permanent DM for this server. If you feel this is in error, reroll a bard and cry for attention.")
            elseif line1 == '0' or line1 == nil then --true if the guild does NOT already have a permanent DM
                print('temporary or no DM')
                guildDmRecord = io.open('./guilds/' .. message.guild.id, 'w')
                guildDmRecord:write('0\n' .. mention[1].id)
                guildDmRecord:close()
                message:reply(mention[1].name .. " successfully set as this server's current DM.")
            else
                print('Error dm-2: \"Who fucked with the guild file?\"')
                message:reply('Error dm-2: \"Who fucked with the guild file?\" ' .. client.owner.mentionString .. " Please help, Daddy. O_O")
                guildDmRecord = io.open('./guilds/' .. message.guild.id, 'w')
                guildDmRecord:write('0\n' .. mention[1].id)
                guildDmRecord:close()
                message:reply("Successfully overwrote corrupted guild file. " .. mention[1].name .. " set as this server's current DM.")
            end
        elseif #mention == 0 then --true if no user was mentioned
            print('no mentions')
            if line1 == '1' then --true if the guild already has a permanent DM
                print('permanent DM')
                local currentDm = message.guild:getMember(line2).name
                message:reply(currentDm .. " is the permanent DM for this server. If you feel this is in error, reroll a bard and cry for attention.")
            elseif line1 == '0' then --true if the guild has a temporary DM
                print('temporary DM')
                local currentDm = message.guild:getMember(line2).name
                message:reply(currentDm .. ' is currently the DM. If you were trying to change that, RTFM.')
            else --true if line1 could not be interpreted, and therefore the file is either corrupt or empty
                print('no DM')
                message:reply("Ummm... you kinda have to... like... tell me who you want to the DM to be...")
            end
        elseif #mention > 1 then --true if multiple users were mentioned
            print('multiple mentions')
            message:reply('Whoa, now. Multiple dungeon masters is NOT as kinky as you might think.')
        else --length of mention fucked up
            message:reply('Error dm-1: \"How the fuck is there a negative number of mentioned users?!?!?!\" ' .. client.owner.mentionString .. " Please help, Daddy. O_O")
        end
    else --message was not sent in a guild
        print('guild not found. message was in PMs.')
        message:reply("If you want a private roleplay with me, ***I'm*** the dungeon master :wink:.")
    end
end

local function pdm(client, logger, message, text)
    if message.guild then --if the message was sent in a guild
        print('in guild')
        if message.author.id == message.guild.ownerId then --message author is guild owner
            print('user has permissions')
            guildDmRecord = io.open('./guilds/' .. message.guild.id, 'w')
            guildDmRecord:write('1\n' .. message.author.id)
            guildDmRecord:close()
            message:reply('***__ALL HAIL OUR GOD AND DAMNATION, ' .. message.author.name:upper() .. "!!!__***")
        else --message author is not guild owner.
            print('user does not have permissions')
            message:reply('You attempt to cast the Divine Spell of Godly Ascension...\n\nand then you remember you have no power here...')
        end
    else --message was not sent in a guild
        print('not in guild')
        message:reply("If you want a private roleplay with me, ***I'm*** the dungeon master :wink:.")
    end
end

local function spam(client, logger, message, text)
    local function loop(channel, text)
        --the actual loop that spams the messages out.
        for i=1, 5 do
            channel:send(text)
        end
        channel:send('done')
    end
    
    if message.guild then
        if message.guild:getMember(message.author):hasPermission(0x00000008) then
            if text~='' then
                if message.guild:getMember(client.user):hasPermission(0x00000010) then
                    spamChannel = message.guild:createTextChannel('Spamming')
                    loop(spamChannel, text)
                    spamChannel:delete()
                else
                    loop(message.channel, text)
                end
            else
                message:reply('Try again, but this time, tell me what to FUCKING SAY!!!')
            end
        else
            message:reply("You don't have the authority to have me spam for you.")
        end
    else
        if text ~='' then
            loop(message.channel, text)
        else
            message:reply("Try again, but this time, tell me what to FUCKING SAY!!!")
        end
    end    
end

return {
    dm = dm,
    pdm = pdm,
    spam = spam,
}