local function lazarus(client, logger, message, text)
    messsage:reply("RUUUUUUUU-huhuhuuuuuuuuun!!!")
    client:setStatus('dnd')
    
end

local function notbadforasorceror(client, logger, message, text)
    message:reply("Fuck you, Angus.")
end

return {
    lazarus = lazarus,
    notbadforasorceror = notbadforasorceror,
    }