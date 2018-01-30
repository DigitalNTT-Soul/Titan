--variable bank
    local discordia = require('discordia')
    local client = discordia.Client()
    local logger = discordia.Logger(4 --[[debug]], '%F %T', discordia.log)
    local config = require('./config.lua')
    local name = config[5]
    local prefix = config[2]
    local playing = config[3]
    local owner
    local admin0
    local admin1
    local admin2
    --local testtable = {"this", {"table", {"is", {"nested", {"as", {"fuck"}}}}}}
    local seed = math.random()*os.clock()
    local handler = require("./commandHandler.lua")
--end

local function unload(input) --takes argument, and unpacks it all into a single, multi-line string
    local result = ""
    if type(input)=="string" then
        result = result .. input .. "\n"
    elseif (type(input)=="number" or type(input)=="boolean") then
        result = result .. tostring(input) .. "\n"
    elseif type(input)=="nil" then
        result = result .. "nil\n"
    elseif type(input)=="function" then
        result = result .. "unexpected function object\n"
    elseif type(input)=="thread" then
        result = result .. "unexpected thread object\n"
    elseif type(input)=="userdata" then
        result = result .. "unexpected userdata object\n"
    elseif type(input)=="table" then
        result = result .. "{\n"
        for i=1, #input do
            result = result .. unload(input[i])
        end
        result = result .. "}\n"
    else
        result = result .. "unidentifiable data type\n"
    end
    return result
end

client:once('ready', function ()
    client:setUsername(name)
    client:setGame(playing)
    owner = client.owner  --Me
    admin0 = client:getUser(config[4][1]) --Sage
    admin1 = client:getUser(config[4][2]) --Christian
    admin2 = client:getUser(config[4][3]) --Michael

    --the rest of this is purely debug scaffolding. i.e. only used for the purpose of making development easier.
    --owner:send("Bot ready with the following configurations:" .. unload(config))
    --owner:send("ping")
    --admin0:send("ping")
    --admin1:send("ping")
    --admin2:send("ping")
    --client:setStatus('invisible') client:stop()
end)

client:on('guildAvailable', function (guild)
    --expects a guild object. If none of the bot's admins are present in the guild, bot will automatically message guild owner and leave guild.
    adminCheck = (guild:getMember(client.owner) or guild:getMember(config[4][1]) or guild:getMember(config[4][2]) or guild:getMember(config[4][3]))
    if adminCheck then
        logger:log(3 --[[info]], "Guild '" .. guild.name .. "' (" .. guild.id .. ") loaded and verified through " .. adminCheck.user.fullname .. ".")
    elseif not adminCheck then
        guild.owner:send("My daddy said not to talk to strangers, and since he's not in " .. guild.name .." , I need to go home now.")
        logger:log(3 --[[info]], "STRANGER DANGER! Leaving guild '" .. guild.name .."' (" .. guild.id .. ") because no admins were present.")
        guild:leave()
    else
        logger:log(2 --[[warning]], "Error in " .. guild.name .. "(" .. guild.id .. "): could not verify admin presence for unknown reason.")
    end
end)

client:on('messageCreate', function (message) --parses out prefix if necessary, then submits remaining text to handler
    if message.author~=client.user then
        if message.channel.type==1 then
            if string.sub(message.content, 1, #prefix)==prefix then
                local text = string.lower(string.sub(message.content, #prefix+1, -1))
                owner:send(message.author.fullname .. ' ' .. message.content) --scaffolding
                owner:send(text) --scaffolding
                handler(client, logger, message, text)
            else
                local text = string.lower(message.content)
                owner:send(message.author.fullname .. ' ' .. message.content) --scaffolding
                handler(client, logger, message, text)
            end
        elseif message.channel.type==0 then
            if string.sub(message.content, 1, #prefix)==prefix then
                local text = string.lower(string.sub(message.content, #prefix+1, -1))
                owner:send(message.author.fullname .. ' ' .. message.content) --scaffolding
                owner:send(text) --scaffolding
                handler(client, logger, message, text)
            end
        end
    end
end)

client:on('raw', function()
    ---constantly generates new RNG seeds every time the bot receives ANY data from Discord's API
    for iter=1, math.random(10,20) do
        math.randomseed(math.random()*os.clock()*iter)
    end
    --logger:log(4 --[[debug]], "RNG Seed feed: " .. seed)
end)

client:run('Bot '.. config[1])