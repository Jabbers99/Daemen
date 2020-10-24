-- Define Global Table
_G.Daemen = {}

-- Import Main Discordia module
_G.Daemen.Discordia = require('discordia')

-- Load Deps
require('./daemen_deps')

-- Load Helpers
require('./helpers')

-- Initalise Client
_G.Daemen.Client = _G.Daemen.Discordia.Client()

-- Load Modules
_G.Daemen.Functions.LoadModules()

-- Start the bot
require('./bot')