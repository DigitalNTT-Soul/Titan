--variable bank
    local info = require("./info.lua")
    local dm = require("./dm.lua")
    local mP = require("./mmlParty.lua")
    local dice = require("./dice.lua")
    local mM = require("./mmlMechanics.lua")
    local debug = require("./debug.lua")
--]]

local commands={
    {
        name = "help",
        usage = "``help`` PMs a list of available commands.",
        dusage = "``help`` PMs a list of available commands.\n``help <functionname>`` PMs detailed usage information for a specified command.",--missing usage data
        action = info.help,
        },
    {
        name="info",
        usage = "``info`` Displays general information about the bot.",
        dusage="``info`` Displays general information about the bot. This information is sent to the channel the command was used from.",
        action=info.info,
        },
    {
        name="dm",
        usage = "``dm`` Sets the mentioned user as this server's current DM. Mentioned user must have server administrator permissions.",
        dusage="``dm <mention>`` Sets the mentioned user as this server's current DM. Mentioned user must have server administrator permissions.",
        action=dm.dm,
        },
    {
        name="pdm",
        usage = "``pdm`` Sets the server owner as this server's permanent DM. Must be server owner to use the command.",
        dusage= "``pdm`` Sets the server owner as this server's permanent DM. Must be server owner to use the command.",
        action=dm.pdm,
        },
    {
        name="spam",
        usage = "``spam <text>`` Repeatedly spams <text> up to 100 times.",
        dusage = "``spam <text>`` Repeatedly spams <text> up to 100 times.\nIf sent in PMs, the bot simply PMs <text> to you 100 times.\nIf sent in a guild where the bot has permission to create and delete channels, the bot will create a temporary channel, send the spam messsages there, and then delete the channel.\nIf sent in a guild where the bot does *not* have those permissions, the bot simply replies in the same channel (only 10 times in this case)",
        action = dm.spam,
        },
    {
        name="cs",
        usage = "``cs`` displays an organized table of the user's MML character sheet, if they have one. Please contact the bot owner to set up or change your character sheet.",
        dusage="``cs`` displays an organized table of the user's MML character sheet, if they have one. Please contact the bot owner to set up or change your character sheet.",
        action=mP.cs,
        },
    {
        name="roll",
        usage = "``roll`` Rolls a dice expression, defaulting to 1d20 if none is provided.",
        dusage="``roll`` Rolls 1d20.\n``roll [dice expression]`` will roll the specified dice expression.\n``roll [dice expression] [< > << >>] [number]`` will roll the dice expression and automatically compare it to the number. single ``<`` or ``>`` means it can compare an entire complex dice expression to the number once, while double ``<<`` or ``>>`` will compare each roll of a simple dice expression to the number.",--need more usage information
        action=dice.roll,
        },
    {
        name="max",
        usage = "``max`` Calculates and displays the maximum possible roll for a valid dice expression.",
        dusage="``max [dice expression]`` Calculates and displays the maximum possible roll for a valid dice expression.",
        action=dice.max,
        },
    {
        name="min",
        usage = "``min`` Calculates and displays the minimum possible roll for a valid dice expression.",
        dusage="``min [dice expression]`` Calculates and displays the minimum possible roll for a valid dice expression.,",
        action=dice.min,
        },
    {
        name="acon",
        usage=nil,
        dusage=nil,
        action=dice.acon,
        },
    {
        name="acoff",
        usage=nil,
        dusage=nil,
        action=dice.acoff,
        },
    {
        name="kill",
        usage=nil,
        dusage=nil,
        action=debug.kill,
        },
    {
        name="reboot",
        usage=nil,
        dusage=nil,
        action=debug.reboot,
        },
    {
        name="exec",
        usage=nil,
        dusage=nil,
        action=debug.exec,
        },
}

return commands