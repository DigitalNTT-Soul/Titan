local function help(client, logger, message, text)
    local cmdTab = require("./commandTable.lua")
    local mainHelp = ''
    for i=1, #cmdTab do
        if cmdTab[i] and cmdTab[i]['usage'] then
            mainHelp = mainHelp .. cmdTab[i]['usage'] .. '\n'
        end
    end
    if not text or text=='' then
        if message.channel.type==0 then
            message:reply(message.author.mentionString .. " Check your PMs :)")
        end
        return message.author:send(mainHelp)
    else
        local status=0
        for i=1, #cmdTab do
            if text==cmdTab[i]['name'] and cmdTab[i]['dusage'] then
                status=1
                if message.channel.type==0 then
                    message:reply(message.author.mentionString .. " Check your PMs :)")
                end
                return message.author:send(cmdTab[i]['dusage'])
            end
        end
        if status==0 then
            return message.author:send("I couldn't find a command called '" .. text .. "'. Here's the main list instead.\n" .. mainHelp)
        end
    end
end

local function info(client, logger, message, text)
    local config = require('./config.lua')

    return message:reply('**'.. config[5] ..'** v0.3i created by Dylan Ruppell (DigitalNTT Soul).\n\nThis copy of the bot is owned by ' .. client.owner.fullname ..'.')
end

return {
    help = help,
    info = info,
}