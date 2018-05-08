local functions = {}

client:_loadModule('./modules/info.lua',            'info',         functions)
client:_loadModule('./modules/dm.lua',              'dm',           functions)
client:_loadModule('./modules/mmlParty.lua',        'mP',           functions)
client:_loadModule('./modules/dice.lua',            'dice',         functions)
client:_loadModule('./modules/mmlMechanics.lua',    'mM',           functions)
client:_loadModule('./modules/debug.lua',           'debug',        functions)
client:_loadModule('./modules/gimmix.lua',          'gimmix',       functions)
client:_loadModule('./modules/warframeTools.lua',   'warframeTools',functions)

client:_loadModule('./test.lua',                    'test',         functions)

local commands={
    help = {
        name = "help",
        usage = "``help`` PMs a list of available commands.",
        dusage = "``help`` PMs a list of available commands.\n``help <functionname>`` PMs detailed usage information for a specified command.",--missing usage data
        action = functions.info.help,
        },
    info = {
        name="info",
        usage = "``info`` Displays general information about the bot.",
        dusage="``info`` Displays general information about the bot. This information is sent to the channel the command was used from.",
        action= functions.info.info,
        },
    dm = {
        name="dm",
        usage = "``dm`` Sets the mentioned user as this server's current DM. Mentioned user must have server administrator permissions.",
        dusage="``dm <mention>`` Sets the mentioned user as this server's current DM. Mentioned user must have server administrator permissions.",
        action=functions.dm.dm,
        },
    pdm = {
        name="pdm",
        usage = "``pdm`` Sets the server owner as this server's permanent DM. Must be server owner to use the command.",
        dusage= "``pdm`` Sets the server owner as this server's permanent DM. Must be server owner to use the command.",
        action=functions.dm.pdm,
        },
    spam = {
        name="spam",
        usage = "``spam <text>`` Repeatedly spams <text> up to 5 times. User must have server administrator permissions.",
        dusage = "``spam <text>`` Repeatedly spams <text> up to 5 times.\nIf sent in PMs, the bot simply PMs <text> to you 5 times.\nIf sent in a guild where the bot has permission to create and delete channels, the bot will create a temporary channel, send the spam messages there, and then delete the channel.\nIf sent in a guild where the bot does *not* have those permissions, the bot simply replies in the same channel.",
        action = functions.dm.spam,
        },
    cs = {
        name="cs",
        usage = "``cs`` displays an organized table of the user's MML character sheet, if they have one. Please contact the bot owner to set up or change your character sheet.",
        dusage="``cs`` displays an organized table of the user's MML character sheet, if they have one. Please contact the bot owner to set up or change your character sheet.",
        action=functions.mP.cs,
        },
    roll = {
        name="roll",
        usage = "``roll`` Rolls a dice expression, defaulting to 1d20 if none is provided.",
        dusage="**Dice Expressions**\n``roll`` Rolls 1d20.\n``roll 10`` Rolls 1d10.\n``roll 4d20`` Rolls 4d20.\n``roll 3d6 + 2`` Rolls 3d6, then adds 2.\n``roll 3d20 - d10 + 6`` Rolls 3d20, subtracts 1d10, then adds 6.\n\n**Comparisons**\n``roll 2d20 + 4 > 10`` Rolls 2d20 + 4, and compares the total to 10.\n``roll 6d20 >> 14`` Rolls 6d20 and compares each d20 result to 14.",
        action=functions.dice.roll,
        },
    max = {
        name="max",
        usage = "``max`` Calculates and displays the maximum possible roll for a valid dice expression.",
        dusage="``max [dice expression]`` Calculates and displays the maximum possible roll for a valid dice expression. Use ``" .. core.config.prefix .. "help roll`` to see examples of valid dice expressions.",
        action=functions.dice.max,
        },
    min = {
        name="min",
        usage = "``min`` Calculates and displays the minimum possible roll for a valid dice expression.",
        dusage="``min [dice expression]`` Calculates and displays the minimum possible roll for a valid dice expression. Use ``" .. core.config.prefix .. "help roll`` to see examples of valid dice expressions.",
        action=functions.dice.min,
        },
    superon = {
        name="superon",
        usage=nil,
        dusage=nil,
        action=functions.dice.superon,
        },
    superoff = {
        name="superoff",
        usage=nil,
        dusage=nil,
        action=functions.dice.superoff,
        },
    superother = {
        name="superother",
        usage=nil,
        dusage=nil,
        action=functions.dice.superother,
        },
    kill = {
        name="kill",
        usage=nil,
        dusage="``kill`` turns the bot off. Can only be used by the owner of the bot.",
        action=functions.debug.kill,
        },
    reboot = {
        name="reboot",
        usage=nil,
        dusage="``reboot`` reboots the bot. Can only be used by the owner of the bot.",
        action=functions.debug.reboot,
        },
    exec = {
        name="exec",
        usage=nil,
        dusage="``exec`` makes the bot run Lua code for the user. Can only be used by the owner of the bot.",
        action=functions.debug.exec,
        },
    lazarus = {
        name="lazarus",
        usage="``lazarus`` Just for Lols",
        dusage="``lazarus`` Just for Lols. Try it.",
        action=functions.gimmix.lazarus,
        },
    notbadforasorceror = {
        name="notbadforasorceror",
        usage="``notbadforasorceror`` Just for Lols",
        dusage="``notbadforasorceror`` Just for Lols. Try it.",
        action=functions.gimmix.notbadforasorceror,
        },
    unnaturallust = {
        name="unnaturallust",
        usage="``unnaturallust`` Just for Lols",
        dusage="``unnaturallust`` Just for Lols. Try it.",
        action=functions.gimmix.unnaturallust,
        },
    fuckthisgame = {
        name="fuckthisgame",
        usage="``fuckthisgame`` Just for Lols",
        dusage="``fuckthisgame`` Just for Lols. Try it.",
        action=functions.gimmix.fuckthisgame,
        },
    damnitconor = {
        name="damnitconor",
        usage = "``damnitconor`` Just for Lols",
        dusage = "``damnitconor`` Just for Lols. Try it.",
        action = functions.gimmix.damnitconor,
    },
    test = {
        name = 'test',
        usage="``test`` whatever I'm currently working on.",
        dusage ="``test`` This is where command-babies come from.",
        action = functions.test.test,
        },
    appraise = {
        name = 'appraise',
        usage = "``appraise <integer 0-3> <6 more positive integers>`` uses the 7 entered numbers to calculate the statistical value of a given relic",
        dusage = "``appraise <integer 0-3 representing the refinement level of a relic> <6 more positive integers indicating the platinum value of each drop>`` uses the 7 entered numbers to calculate the statistical value of a given relic",
        action = functions.warframeTools.appraise,
        },
}

return commands