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
    if whitelist[message.author.id] and message.channel.type==1 then
        if tonumber(message._text) and tonumber(message._text)>=1 and tonumber(message._text)<=100 then
            whitelist[message.author.id] = tonumber(message._text) / 100
            message:reply("RNG cheat activated: You will now roll in the " .. message._text .. "th percentile.")
        else
            message:reply("I'm sorry. You must enter a number between 1 and 100 (inclusive) in order to activate this cheat.")
        end
    end
    return nil
end

local function superoff(client, core, message)
    if whitelist[message.author.id] and message.channel.type==1 then
        whitelist[message.author.id] = whitelistDefaults[message.author.id]
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