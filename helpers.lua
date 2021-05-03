_G.Daemen.Functions = {}
local fs = _G.Daemen.Deps.FS

-- Logger Helper
local logger = _G.Daemen.Discordia.Logger(3, os.date("%Y-%m-%d %X"))
function _G.Daemen.Functions.Log(text, type) logger:log(type, text) end

-- Load Module
function _G.Daemen.Functions.LoadModule(module)
    local path = "modules/"
    local fs = _G.Daemen.Deps.FS


    -- Prepare environment table for module code and allow access of _G
    local env = setmetatable({}, { __index = _G })

    -- Load all dependencies into module code
    for moduleName, data in pairs(_G.Daemen.Deps) do
        env[moduleName] = data
    end
    -- Read module
    local fil = fs.readFileSync(path..module)

    -- Attempt to load module
    local fn, syntaxErr = load(fil, "Daemen", "t", env)
    if not fn then print("There was a syntax error loading module "..module.."\n"..syntaxErr) return false end     -- Handle syntax errors

    -- Attempt to exec module
    local suc, runtimeErr = pcall(fn)
    if not suc then print("There was a runtime error loading module "..module.."\n"..runtimeErr) return false end     -- Handle runtime errors

    _G.Daemen.Functions.Log("Loaded module "..module.."!", 3)
end

-- Load all modules
function _G.Daemen.Functions.LoadModules()
    _G.Daemen.Functions.Log("----- Loading Modules -----", 3)
    for _, moduleName in pairs(fs.readdirSync('modules/')) do
        _G.Daemen.Functions.LoadModule(moduleName)
    end
    _G.Daemen.Functions.Log("----- Loaded Modules -----", 3)
end

-- Load commands
_G.Daemen.Commands = {}
function _G.Daemen.Functions.AddCommand(cmd, callback, args, aliases)
    _G.Daemen.Commands[_G.Daemen.Settings.Prefix..cmd] = {callback, args, aliases or {}}
end


function _G.Daemen.Functions.FindMentions(args)
    local members = {}
    for _, arg in pairs(args) do
        local mention = arg:match('<@!?(%d+)>')
        if mention then
            table.insert(members, mention)
        else
            
        end
    end
    return members
end


function _G.Daemen.Functions.MakeSafe(str)
    return str:gsub("[`@]", "")
end

-- Parses time, used in the reminder module
function _G.Daemen.Functions.ParseHumanTime(str)
    str = str:lower()

    -- should accept d, day, days for each unit 
    local acceptedTimes = {"second", "minute", "hour", "day"}
    
    for _, unit in pairs(acceptedTimes) do
        -- Normal unit, first letter or plural
        if str == unit or str == unit:sub(1,1) or str == unit.."s" then
            return unit
        end
    end
    return false
end
function _G.Daemen.Functions.firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end
function _G.Daemen.Functions.GetDefaultFooter(u)
    return {
        text = "Requested by "..u.tag,
        icon_url = u.avatarURL
    }
end