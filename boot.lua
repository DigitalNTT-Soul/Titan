local discordia = require('discordia')
local client = discordia.Client()
local core = {}
client._logger = discordia.Logger(3, '%F %T', discordia.log)

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

    --if pcall was successful, save the results inside core.
    object[moduleName] = result
    return object
end

function client:_init(core)
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
    client._reboot = coroutine.wrap(self._init)
    core = client:_reboot(core)
    return core
end

core = client:_start(core)
client:run(core.config.token)