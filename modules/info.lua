-- � 2017-2018 Dylan Ruppell
local function help(client, core, message)
    local cmdTab = core.commands
    local text = message._text
    local mainHelp = ''
    for k, v in pairs(cmdTab) do
        if v.usage then
            mainHelp = mainHelp .. v.usage .. '\n'
        end
    end
    if not text or text=='' then
        if message.channel.type==0 then
            message:reply(message.author.mentionString .. " Check your PMs :)")
        end
        return message.author:send(mainHelp)
    elseif cmdTab[text] and cmdTab[text].dusage then
        if message.channel.type==0 then
            message:reply(message.author.mentionString .. " Check your PMs :)")
        end
        return message.author:send(cmdTab[text].dusage)
    else
        message:reply("I couldn't find a command called `" .. text .. "`. Check your PMs for the main list instead.")
        return message.author:send(mainHelp)
    end
end

local function info(client, core, message)
    return message:reply('**' .. core.config.name .. '** v0.6 **α** Created by Dylan Ruppell (DigitalNTT Soul).\n\nThis copy of the bot is owned by ' .. client.owner.fullname ..'.')--(α) (β) (Ω)
end

return {
    help = help,
    info = info,
}