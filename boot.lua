--[[
In this bot architecture, there are 2 critical variables and 2 files that must be present
The two critical variables are *client* and *core*. 
    client refers to a handful of static and constantly reused values and functions (such as the actual established connection to discord servers) and is not intended to be changed at all (listeners are currently susceptible to runtime errors)
    core refers to all the logic behind the bot that may be unstable or in development at any given time during the bot's operation, such as event listeners and individual command functions

The two required files are a "./config.lua" and a "./listeners.lua". Both files must return a key-value table.
    config must return at least one entry, with key: "token" and value: "Bot <token>"
    listeners must return a table of key: "<name_of_event>" and value: functionToHandleEvent
        Note that you return the function object. You do not CALL the given function.
--]]

local discordia = require('discordia')
local client = discordia.Client()
local core = {}
client._logger = discordia.Logger(3, '%F %T', discordia.log)

function client:_unload(input) --simple debug tool, takes argument of any dataType, and unpacks it all into a single, multi-line string
    local result = ""
    if type(input)=="string" then
        result = result .. "'" .. input .. "'" .. "\n"
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
        for k, v in pairs(input) do
            result = result .. k .. ": " .. self:_unload(input[k])
        end
        result = result .. "}\n"        
    else
        result = result .. "unidentifiable data type\n"
    end
    return result
end

function client:_coreEnv(core)
    self._env = setmetatable({
        discordia = discordia,
        require = require,
        client = self,
        core = core,
    }, { __index = _G })
end

function client:_loadModule(path, moduleName, object)
    --makes sure that all the required variables are present and performs a minimalistic check to see if they'll be usable
    if not path or not moduleName or not object or path=='' or moduleName=='' then return object end

    --loads module into *buffer*, converts buffer into *code* and, then closes buffer
    local buffer = io.open(path, 'r')
    local code
    if buffer then code = buffer:read('*a') buffer:close() end
    
    --if the code variable is nil or empty, there's no point in proceeding further and the function basically failed
    if not code or code=='' then return object end

    --loads code as a function and tests its syntax validity. if it fails, the function fails and the module doesn't get loaded.
    local fn, syntaxError = load(code, moduleName, 't', self._env)
    if not fn then print(syntaxError) return object end

    --attempts to call the previously loaded function to fetch the table. If it fails, the function fails and the module doesn't get loaded.
    local success, result = pcall(fn)
    if not success then print(result) return object end

    --if pcall was successful, save the results inside *object*.
    object[moduleName] = result
    return object
end

function client:_init(core)
    --infinite loop function, designed to be run as a coroutine. Initializes everything the bot needs, and hits the coroutine.yield.
    --under certain circumstances, such as an individual command being imported improperly, other functions will resume this coroutine, which causes the final step of the loop to occur, and the loop begins anew.
    while true do
        print('initializing core')
        core = {}
        self:_coreEnv(core)
        core = self:_loadModule('./config.lua', 'config', core)
        self:_coreEnv(core)
        core = self:_loadModule('./listeners.lua', 'listeners', core)
        self:_coreEnv(core)
        for k, v in pairs(core.listeners) do
            print('Applying listener for ' .. k)
            self:on(k, v)
        end
        coroutine.yield(core)
        for k, v in pairs(core.listeners) do
            print('Clearing listener for ' .. k)
            self:removeAllListeners(k)
        end
    end
end

function client:_start(core)
    --calls the function to initialize the bot and returns the core object.
    client._reboot = coroutine.wrap(self._init)
    core = client:_reboot(core)
    return core
end

core = client:_start(core)
client:run(core.config.token)