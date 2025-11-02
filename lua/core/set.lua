local utils = require("core.utils")

-----------------------------------------------------------
-- General
-----------------------------------------------------------
g.skip_defaults_vim = 1
opt.langmenu = "en_US"
opt.nu = true
-- opt.autochdir = true
opt.autochdir = false -- disabling for harpoon /  telescope

------------------------------------------------------------
-- Memory, CPU
----------------------------------------------------------
-- perf
-- ok going to add this back 
-- opt.shadafile = "NONE"

-- swapfiles and backup / undo
opt.swapfile = false
opt.backup = false

-- autocomplete
opt.completeopt=noinsert,menuone,noselect
opt.lazyredraw = true       -- Faster scrolling

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.smartindent = true
opt.wrap = false
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.smartindent = true

-- block mode changes
opt.virtualedit = "block"

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true           -- Show line number
opt.relativenumber = true   -- Relative line numbers
opt.showmatch = true        -- Highlight matching parenthesis
---------------
-- Folding
---------------
opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
opt.foldlevel = 99
opt.fillchars = { fold = "\\" }
opt.foldtext = "v:lua.CustomFoldText()"


-- Set local options in an autocmd or filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.GetPotionFold(v:lnum)"
  end,
})

-- Fold expression function
function _G.GetPotionFold(lnum)
  local line = vim.fn.getline(lnum)
  if line:match("^%s*$") then
    return "-1"
  end

  local function indentLevel(n)
    return vim.fn.indent(n) / vim.o.shiftwidth
  end

  local function nextNonBlankLine(n)
    local numlines = vim.fn.line("$")
    for i = n + 1, numlines do
      if vim.fn.getline(i):match("%S") then
        return i
      end
    end
    return -2
  end

  local this_indent = indentLevel(lnum)
  local next_indent = indentLevel(nextNonBlankLine(lnum))

  if next_indent == this_indent then
    return tostring(this_indent)
  elseif next_indent < this_indent then
    return tostring(this_indent)
  elseif next_indent > this_indent then
    return ">" .. next_indent
  end
end

-- Fold text display function
function _G.CustomFoldText()
  local fs = vim.v.foldstart
  while vim.fn.getline(fs):match("^%s*$") do
    fs = vim.fn.nextnonblank(fs + 1)
    if fs == 0 or fs > vim.v.foldend then break end
  end

  local line
  if fs > vim.v.foldend then
    line = vim.fn.getline(vim.v.foldstart)
  else
    line = vim.fn.substitute(vim.fn.getline(fs), "\t", string.rep(" ", vim.o.tabstop), "g")
  end

  local w = vim.fn.winwidth(0) - vim.o.foldcolumn - (vim.wo.number and 8 or 0)
  local foldSize = 1 + vim.v.foldend - vim.v.foldstart
  local foldSizeStr = " " .. foldSize .. " lines "
  local foldLevelStr = string.rep("+--", vim.v.foldlevel)
  local expansionString = string.rep(" ", w - vim.fn.strwidth(foldSizeStr .. line .. foldLevelStr))
  return line .. expansionString .. foldSizeStr .. foldLevelStr
end



opt.colorcolumn = '80'      -- Line length marker at 80 columns
opt.splitright = true       -- Vertical split to the right
opt.splitbelow = true       -- Horizontal split to the bottom
-- search
opt.ignorecase = true       -- Ignore case letters when search
opt.hlsearch = false
opt.incsearch = true
opt.inccommand = "split"
opt.smartcase = true        -- Ignore lowercase for the whole pattern
opt.linebreak = true        -- Wrap on word boundary
opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.laststatus=3            -- Set global statusline
opt.signcolumn = "yes"

api.nvim_set_hl(0, "LineNrAbove", { 
  fg = "#1e66f5",
  
  bold = true })
api.nvim_set_hl(0, "LineNr", { 
  -- fg = "white",
  bold = true })
api.nvim_set_hl(0, "LineNrBelow", { 
  fg = "#d20f39",
  bold = true })



-----------------------------------------------------------
-- clipboard settings
-----------------------------------------------------------
-- Windows OS
if g.IS_WINDOWS then
  opt.undodir = os.getenv("LOCALAPPDATA") .. "/.cache/vim/undodir"
  g.python3_host_prog = os.getenv("LOCALAPPDATA") .. "/Microsoft/WindowsApps/python.exe"
else
  opt.undodir = os.getenv("HOME") .. "/.cache/vim/undodir"
end

-- WSL
if vim.fn.has('wsl') == 1 then
    g.clipboard = {
        name = 'WslClipboard',
        copy = {
            ['+'] = 'clip.exe',
            ['*'] = 'clip.exe',
        },
        paste = {
            ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end

opt.undofile = true
opt.cursorline = true
opt.updatetime = 50
opt.list = true
opt.scrolloff = 999 -- keep cursor centered
opt.listchars = "tab:⇤–⇥,trail:·,extends:⇢,precedes:⇠,space:·"
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
opt.conceallevel = 0 -- this is super annoying when trying to read json


--autocmd FileType json setlocal formatprg=jq
-- Restore cursor to file position in previous editing session
    -- highlights yanked text

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append "sI"

--
