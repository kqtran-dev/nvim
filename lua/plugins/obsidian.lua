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

local windows_events = {
    "BufReadPre " .. "\\**\\main\\**.md",
    "BufNewFile " .. "\\**\\main\\**.md",
}

local macos_events = {
    "BufReadPre " .. "/**/main/**.md",
    "BufNewFile " .. "/**/main/**.md",
}

if utils.os_name == "Windows NT" then
    myevents = windows_events
    myworkspace = {["iCloud~md~obsidian"] = "~/iCloudDrive/iCloud~md~obsidian"}
elseif utils.os_name == "Darwin" then
    myevents = macos_events
    myworkspace = {["Documents"] = "/Users/k/Library/Mobile Documents/iCloud~md~obsidian/Documents"}
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
  --ft = "markdown",
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
  opts = {
      workspaces = myworkspace
    },
  finder_mappings = {
        -- Define the mappings for the telescope finder.
        new = "<C-x>",
  },
  mappings = {
        ["gf"] = {
            action = function()
            return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
        },
    },
    completion = {
    nvim_cmp = true,
    min_chars = 2,
    new_notes_location = "current_dir",
    log_level= vim.log.levels.INFO,
    -- Control how wiki links are completed with these (mutually exclusive) options:
    --
    -- 1. Whether to add the note ID during completion.
    -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
    -- Mutually exclusive with 'prepend_note_path' and 'use_path_only'.
    prepend_note_id = true,
    -- 2. Whether to add the note path during completion.
    -- E.g. "[[Foo" completes to "[[notes/foo|Foo]]" assuming "notes/foo.md" is the path of the note.
    -- Mutually exclusive with 'prepend_note_id' and 'use_path_only'.
    prepend_note_path = false,
    -- 3. Whether to only use paths during completion.
    -- E.g. "[[Foo" completes to "[[notes/foo]]" assuming "notes/foo.md" is the path of the note.
    -- Mutually exclusive with 'prepend_note_id' and 'prepend_note_path'.
    use_path_only = false,
  },
  note_id_func = function(title)
    local suffix = ""
    if title ~= nil then
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return tostring(os.time()) .. "-" .. suffix
  end,
  ui = {
    enable = true,  -- set to false to disable all additional syntax features
    update_debounce = 200,  -- update delay after a text change (in milliseconds)
    -- Define how various check-boxes are displayed
    checkboxes = {
      -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
      [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
      ["x"] = { char = "", hl_group = "ObsidianDone" },
      [">"] = { char = "", hl_group = "ObsidianRightArrow" },
      ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
      -- Replace the above with this if you don't have a patched font:
      -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
      -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },
      -- You can also add more custom ones...
    },
    -- Use bullet marks for non-checkbox lists.
    bullets = { char = "•", hl_group = "ObsidianBullet" },
    external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    -- Replace the above with this if you don't have a patched font:
    -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    reference_text = { hl_group = "ObsidianRefText" },
    highlight_text = { hl_group = "ObsidianHighlightText" },
    tags = { hl_group = "ObsidianTag" },
    hl_groups = {
      -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
      ObsidianTodo = { bold = true, fg = "#f78c6c" },
      ObsidianDone = { bold = true, fg = "#89ddff" },
      ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
      ObsidianTilde = { bold = true, fg = "#ff5370" },
      ObsidianBullet = { bold = true, fg = "#89ddff" },
      ObsidianRefText = { underline = true, fg = "#c792ea" },
      ObsidianExtLinkIcon = { fg = "#c792ea" },
      ObsidianTag = { italic = true, fg = "#89ddff" },
      ObsidianHighlightText = { bg = "#209fb5" },
    },
  },
}
