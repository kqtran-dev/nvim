local utils = require("core.utils")
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.spellcapcheck = ""
vim.opt.wrap = true
vim.opt.colorcolumn = "0"

local workspaces_paths = {
    ["Documents"] = "/Users/k/Library/Mobile Documents/iCloud~md~obsidian/Documents", -- macOS
    ["parker"] = "C:\\Users\\568879\\OneDrive - parkercorp\\obsidian\\parker", -- Windows
}

if utils.os_name == "Darwin" then
    myworkspace = {
        {
        name = "Darwin",
        path = "/Users/k/Library/Mobile Documents/iCloud~md~obsidian/Documents"
        }
    }
end

if utils.os_name == "Windows_NT" then
    myworkspace = {
        {
        name = "parker",
        path = "C:\\Users\\568879\\OneDrive - parkercorp\\obsidian\\parker"
        }
    }
end

function setup_workspaces()
    local workspaces = {}
    for name, path in pairs(workspaces_paths) do
        if utils.path_exists(path) then
            table.insert(workspaces, { name = name, path = path })
        end
    end
    return workspaces
end

require("obsidian").setup({
    workspaces = myworkspace,
    log_level = vim.log.levels.INFO,
    new_notes_location = "current_dir",
    preferred_link_style = "wiki",
    completion = {
        nvim_cmp = true,
        min_chars = 2,
    },
    wiki_link_func = function(opts)
        if opts.id == nil then
            return string.format("[[%s]]", opts.label)
        elseif opts.label ~= opts.id then
            return string.format("[[%s|%s]]", opts.id, opts.label)
        else
            return string.format("[[%s]]", opts.id)
        end
    end,
    mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
            action = function()
                return require("obsidian").util.gf_passthrough()
            end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            -- Toggle check-boxes.
            ["<leader>ch"] = {
                action = function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                opts = { buffer = true },
            },
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
        return tostring(suffix)
    end,
    disable_frontmatter = false,
    
        -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
        image_name_func = function()
            -- Prefix image names with timestamp.
            return string.format("%s-", os.time())
        end,

        -- Optional, boolean or a function that takes a filename and returns a boolean.
        -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
        disable_frontmatter = false,

        -- Optional, alternatively you can customize the frontmatter data.
        note_frontmatter_func = function(note)
            -- This is equivalent to the default frontmatter function.
            local out = { id = note.id, aliases = note.aliases, tags = note.tags }
            -- `note.metadata` contains any manually added fields in the frontmatter.
            -- So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end
            return out
        end,


        -- Optional, customize the backlinks interface.
        backlinks = {
            -- The default height of the backlinks location list.
            height = 10,
            -- Whether or not to wrap lines.
            wrap = true,
        },

        -- Optional, customize the tags interface.
        tags = {
            -- The default height of the tags location list.
            height = 10,
            -- Whether or not to wrap lines.
            wrap = true,
        },

        -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
        -- URL it will be ignored but you can customize this behavior here.
        follow_url_func = function(url)
            -- Open the URL in the default web browser.
            vim.fn.jobstart({"open", url})  -- Mac OS
            -- vim.fn.jobstart({"xdg-open", url})  -- linux
        end,

        -- Optional, set to true if you use the Obsidian Advanced URI plugin.
        -- https://github.com/Vinzent03/obsidian-advanced-uri
        use_advanced_uri = false,

        -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
        open_app_foreground = false,

        -- Optional, by default commands like `:ObsidianSearch` will attempt to use
        -- telescope.nvim, fzf-lua, fzf.vim, or mini.pick (in that order), and use the
        -- first one they find. You can set this option to tell obsidian.nvim to always use this
        -- finder.
        finder = "telescope.nvim",

        -- Optional, configure key mappings for the finder. These are the defaults.
        -- If you don't want to set any mappings this way then set
        finder_mappings = {
            -- Create a new note from your query with `:ObsidianSearch` and `:ObsidianQuickSwitch`.
            -- Currently only telescope supports this.
            new = "<C-x>",
        },

        -- Optional, sort search results by "path", "modified", "accessed", or "created".
        -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
        -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
        sort_by = "modified",
        sort_reversed = true,

        -- Optional, determines how certain commands open notes. The valid options are:
        -- 1. "current" (the default) - to always open in the current window
        -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
        -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
        open_notes_in = "current",

        -- Optional, configure additional syntax highlighting / extmarks.
        -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
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
                ObsidianHighlightText = { bg = "#75662e" },
            },
        },

        -- Specify how to handle attachments.
        attachments = {
            -- The default folder to place images in via `:ObsidianPasteImg`.
            -- If this is a relative path it will be interpreted as relative to the vault root.
            -- You can always override this per image by passing a full path to the command instead of just a filename.
            img_folder = "assets/imgs",  -- This is the default
            -- A function that determines the text to insert in the note when pasting an image.
            -- It takes two arguments, the `obsidian.Client` and a plenary `Path` to the image file.
            -- This is the default implementation.
            ---@param client obsidian.Client
            ---@param path Path the absolute path to the image file
            ---@return string
            img_text_func = function(client, path)
                local link_path
                local vault_relative_path = client:vault_relative_path(path)
                if vault_relative_path ~= nil then
                    -- Use relative path if the image is saved in the vault dir.
                    link_path = vault_relative_path
                else
                    -- Otherwise use the absolute path.
                    link_path = tostring(path)
                end
                local display_name = vim.fs.basename(link_path)
                return string.format("![%s](%s)", display_name, link_path)
            end,
        },

        -- Optional, set the YAML parser to use. The valid options are:
        --  * "native" - uses a pure Lua parser that's fast but potentially misses some edge cases.
        --  * "yq" - uses the command-line tool yq (https://github.com/mikefarah/yq), which is more robust
        --    but much slower and needs to be installed separately.
        -- In general you should be using the native parser unless you run into a bug with it, in which
        -- case you can temporarily switch to the "yq" parser until the bug is fixed.
        yaml_parser = "native",
})
