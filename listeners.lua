local config = core.config
local name = config.name
local playing = config.playing
local admins = config.admins
local prefix = config.prefix

local logger = client._logger
discordia.extensions()

local function readyHandler()
    client:setUsername(name)
    client:setGame(playing)
    return
end

local function guildAvailableHandler(guild)
    local adminCheck = (guild:getMember(client.owner) or guild:getMember(admins[1]) or guild:getMember(admins[2]) or guild:getMember(admins[3]))
    if adminCheck then
        return logger:log(3 --[[info]], "Guild `" .. guild.name .. "`` (" .. guild.id .. ") loaded and verified through " .. adminCheck.user.fullname .. ".")
    elseif not adminCheck then
        guild.owner:send("My daddy said not to talk to strangers, and since he's not in ***__" .. guild.name .. "__***, I need to go home now.")
        logger:log(2 --[[warning]], "STRANGER DANGER! Leaving guild `" .. guild.name "` (" .. guild.id .. ") because no admins were present.")
        return --guild:leave()
    else
        return logger:log(1 --[[error]], "Error in " .. guild.name .. " (" .. guild.id .. "): could not verify admin presence for unknown reason.")
    end
end

local function messageCreateHandler(message)
    if not message.author.bot then
        local function parseMessage(message)
            local text = message.content
            if text:startswith(prefix) or message.channel.type==1 then
                local command, arg
                if text:startswith(prefix) then
                    command, arg = text:match("^" .. core.config.prefix .. "(%S+)%s?(.*)$")
                else
                    command, arg = text:match("^(%S+)%s?(.*)$")
                end
                print(command, arg)
                return command, arg
            end
            return nil
        end

        local function checkBlacklist(id)
            local buffer = io.open('./blacklist', 'r')
            local list = {}
            if buffer then list = buffer:read('*a'):split('\n') buffer:close() end
            for i=1, #list do
                if id==list[i] then
                    return true
                end
            end
            return false
        end

        core = client:_loadModule('./commandTable.lua', 'commands', core)
        local commandList = core.commands
        local text = nil
        if discordia.class.type(message)=="Message" then command, text = parseMessage(message) end
        local blacklisted = checkBlacklist(message.author.id)
        if (commandList and command and not blacklisted) then 
            command = commandList[command]
            if command and command.dusage then
                message._text = text
                local success, result = pcall(command.action, client, core, message)
                if not success then
                    message:reply("```Error calling `" .. command.name .. "`:\n" .. result .. "```")
                    return client:_reboot(core)
                end
                return success
            elseif command and not command.dusage then --secret commands
                message._text = text
                local success, result = pcall(command.action, client, core, message)
                if not success then
                    message.author:send("```Error calling `" .. command.name .. "`:\n" .. result .. "```")
                    return client:_reboot(core)
                end
                message:reply("Command not recognized! Type ``" .. prefix .. "help`` for assistance.")
                return success
            end
            logger:log(3, "User " .. message.author.fullname .. " tried `" .. message.content .. "` and failed.")
            return message:reply("Command not recognized! Type ``" .. prefix .. "help`` for assistance.")
        elseif blacklisted then
            return message:reply(message.author.name .. " is blacklisted. You pissed someone off.")
        end
    end
end

local function rawHandler()
    for iter=1, math.random(10, 20) do
        core.seed = math.random()*os.clock()*iter
        math.randomseed(core.seed)
    end
    return --logger:log(4 --[[debuf]], "RNG Seed feed: " .. core.seed)
end

return {
    ready = readyHandler,
    guildAvailable = guildAvailableHandler,
    messageCreate = messageCreateHandler,
    raw = rawHandler,
}