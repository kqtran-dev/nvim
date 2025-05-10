vim.opt_local.wrap = true
vim.opt_local.linebreak = true

-- Optional: spell checking, etc.
-- vim.opt_local.spell = true

-- Wrapped movement
local function set_wrap_movement()
  local map_opts = { expr = true, silent = true, buffer = true }

  local function try_map(mode, lhs, rhs)
    if not vim.fn.mapcheck(lhs, mode):find(rhs, 1, true) then
      vim.keymap.set(mode, lhs, rhs, map_opts)
    end
  end

  if vim.wo.wrap then
    try_map('n', 'j', "v:count == 0 ? 'gj' : 'j'")
    try_map('n', 'k', "v:count == 0 ? 'gk' : 'k'")
    try_map('v', 'j', "v:count == 0 ? 'gj' : 'j'")
    try_map('v', 'k', "v:count == 0 ? 'gk' : 'k'")
  end
end

set_wrap_movement()

