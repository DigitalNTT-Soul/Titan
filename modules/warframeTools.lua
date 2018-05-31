-- � 2017-2018 Dylan Ruppell
local function appraise(client, core, message)
	local text = message._text
	local value
	local t = {}
	local p = "%s*(%d+)"

	local i = 0
	for d in text:gmatch(p) do
		i = i + 1
		t[i] = tonumber(d)
	end

	if #t ~= 7 then
		message:reply("ERROR: expected 7 positive integers")
		return nil
	elseif t[1] > 3 or t[1] < 0 then
		message:reply("ERROR: the first number should be between 0 and 3, inclusive. This number represents the level of the relic's refinement, therefore changing the drop chances of the different items it could drop.")
		return nil
	else
        local tier = table.remove(t, 1)
        local chanceTable = {}
        local chanceString = ""
        if tier == 0 then
            chanceTable = {.76/3, .11, .02}
            chanceString = "25.33%, 11%, 2%"
        elseif tier == 1 then
            chanceTable = {.70/3, .13, .04}
            chanceString = "23.33%, 13%, 4%"
        elseif tier == 2 then
            chanceTable = {.2, .17, .06}
            chanceString = "20%, 17%, 6%"
        elseif tier == 3 then
            chanceTable = {.5/3, .2, .1}
            chanceString = "16.67%, 20%, 10%"
        else
            message:reply("Error: the first number should be between 0 and 3, inclusive. This number represents the level of the relic's refinement, therefore changing the drop chances of the different items it could drop.")
            return nil
        end

        value = ((t[1] + t[2] + t[3]) * chanceTable[1]) + ((t[4] + t[5]) * chanceTable[2]) + (t[6] * chanceTable[3])

        return message:reply("That relic has an approximate value of " .. value .. " platinum. ```Tier " .. tier .. " refinement chances:\n" .. chanceString .. "```")
    end
end

return {
    appraise = appraise,
}