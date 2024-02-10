local utils = require("core.utils")

function path_exists(path)
    local f = io.open(path, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

local workspaces_paths = {
    ["Documents"] = "/Users/k/Library/Mobile Documents/iCloud~md~obsidian/Documents",
    ["iCloud~md~obsidian"] = "~/iCloudDrive/iCloud~md~obsidian",
    ["obsidian"] = "/home/k/obsidian",
}

if utils.os_name == "Windows_NT" then
    myevents = windows_events
    myworkspace = {
        { 
            name = "iCloud~md~obsidian",
            path = "C:\\Users\\k\\iCloudDrive\\iCloud~md~obsidian"
        },
        {
            name = "iCloud~md~obsidian",
            path = "C:/Users/k/iCloudDrive/iCloud~md~obsidian"
        },
        {
            name = "iCloud~md~obsidian",
            path = "C:/Users/k/iCloudDrive/iCloud~md~obsidian"
        },
        {
            name = "iCloud~md~obsidian",
            path = "~/iCloudDrive/iCloud~md~obsidian"
        },
        {
            name = "iCloud~md~obsidian",
            path = "~\\iCloudDrive\\iCloud~md~obsidian"
        }
    }
elseif utils.os_name == "Darwin" then
    myevents = macos_events
    myworkspace = {
        { 
            name = "Documents",
            path = "/Users/k/Library/Mobile Documents/iCloud~md~obsidian/Documents"
        }
    }
else
    myevents = macos_events
end

function setup_workspaces()
    local workspaces = {}
    for name, path in pairs(workspaces_paths) do
        if path_exists(path) then
            table.insert(workspaces, { name = name, path = path })
    end
end
return workspaces
end

return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --     "BufReadPre " .. "/**/main/**.md",
  --     "BufNewFile " .. "/**/main/**.md",
  -- },
  event = myevents,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
    'nvim-telescope/telescope.nvim'
  },
}
