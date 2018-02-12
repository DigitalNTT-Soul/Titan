--[[whitelist storage]]
local whitelistDefaults = {
    ['239563431919747073'] = 0.01, --Dylan
    ['252858420309262338'] = 0.01, --Sage
    ['277618305752367105'] = 0.06, --kaitlynn
    ['254784266959847425'] = 0.01, --michael
}
--[[helper functions]]


--[[actual commands]]
local function roll(client, core, message)

end

local function max(client, core, message)

end

local function min(client, core, message)

end

local function superon(client, core, message)
    if whitelistDefaults[message.author.id] and message.channel.type==1 then
        local new = tonumber(message._text)
        if new and 1 <= new and new <= 100 then
            file = io.open('./database/whitelist/' .. message.author.id, 'w')
            file:write(new / 100)
            file:close()
            message:reply("RNG cheat activated: You will now roll in the " .. message._text .. "th percentile.")
        else
            message:reply("I'm sorry, you must enter a number between 1 and 100 (inclusive) in order to activate this cheat.")
        end
    end
    return nil
end

local function superoff(client, core, message)
    if whitelistDefaults[message.author.id] and message.channel.type==1 then
        local file = io.open('./database/whitelist/' .. message.author.id, 'w')
        file:write(whitelistDefaults[message.author.id])
        file:close()
        message:reply("RNG cheat deactivated: You will now roll normally.")
    end
    return nil
end

return {
    roll = roll,
    max = max,
    min = min,
    superon = superon,
    superoff = superoff,
}