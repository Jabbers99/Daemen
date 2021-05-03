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

-- Create Reminder Table
_G.Daemen.Reminders = {}

-- Start the bot
_G.Daemen.Client:run('Bot '.._G.Daemen.Deps.Settings.Token)