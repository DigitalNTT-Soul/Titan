--[[todo list
user = the person who uses the command
target = the discord account that is mentioned in the command, by the user

info
    help: PMs a list of available commands, or detailed information for a specified command.
	info: Displays information about the bot.
dm
	dm: Sets the user as this server's current DM. User must have Administrator permissions
	pdm: sets the user as this server's permanent DM. User must be server owner.
dice
	roll: rolls specified dice
	max: calculates the maximum possible roll for a dice expression
    min: calculates the minimum possible roll for a dice expression
    hidden (these do not appear in any help documentation)
        acon: turns on the user's anticheat, making all of that user's rolls legitimate.
            can only be used by users on a manually adjusted whitelist. can only be used in private messages with the bot
        acoff: turns off the user's anticheat, allowing the bot to modify that user's maximum and minimum rolls
            can only be used by users on a manually adjusted whitelist. can only be used in private messages with the bot
mmlParty
    cs: displays an organized table of the user's MML character sheet, if they have one.
mmlMechanics    
    <stuff about party and mechanics, TBD>
--]]

--varbank
    local discordia = require('discordia')
    local config = require("./config.lua")
    local prefix = config[2]
    local commands = require("./commandTable.lua")
    --]]

local function blacklist(id)
    local list ={
    }
    for i=1, #list do
        if id==list[i] then
            return false
        end
    end
    return true
end

local function validityChecker(message,text)
    if discordia.class.type(message)=="Message" and type(text)=="string" then
        return true
    else
        logger:log(1 --[[error]], "COMMAND FAILED DUE TO IMPROPER ARGUMENTS!!")
        return false
    end
end

local function handler(client, logger, message, text)
    if validityChecker(message,text) and blacklist(message.author.id) then
        local status=0
        for i=1, #commands do
            if string.sub(text, 1, #commands[i]['name'])==commands[i]['name'] then
                status=1
                text = text:sub(#commands[i]['name']+2, -1)
                print(text) -- scaffolding
                print('command found \"'.. commands[i]['name'] .. '\"') -- scaffolding
                commands[i]['action'](client, logger, message, text)
                break
            end
        end
        if status==0 then
            print('command not found')--scaffolding
            message:reply("Command not recognized! Type ``" .. prefix .. "help`` for assistance.")
            logger:log(3, "User " .. message.author.fullname .. " tried `" .. text .. "` and failed.")
        end
    end
end

return handler