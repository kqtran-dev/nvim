--
-- Settings for neovim config files
--
local M = {}
M.os_name = vim.loop.os_uname().sysname

M.path_exists = function(path)
  local f = io.open(path, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

-- optimized treesitter foldexpr for Neovim >= 0.10.0 -- from LazyVim
function M.foldexpr()
  local buf = vim.api.nvim_get_current_buf()
  if vim.b[buf].ts_folds == nil then
    -- as long as we don't have a filetype, don't bother
    -- checking if treesitter is available (it won't)
    if vim.bo[buf].filetype == "" then
      return "0"
    end
    if vim.bo[buf].filetype:find("dashboard") then
      vim.b[buf].ts_folds = false
    else
      vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
    end
  end
  return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or "0"
end
vim.api.nvim_create_user_command("ReloadConfig", function()
  local plugins = require("lazy").plugins()
  local plugin_names = {}
  for _, plugin in ipairs(plugins) do
    table.insert(plugin_names, plugin.name)
  end

  vim.ui.select(plugin_names, {
    prompt = "Reload plugin",
  }, function(selected)
      if selected then
        require("lazy").reload({ plugins = { selected } })
      end
    end)
end, { desc = "Reload a Lazy plugin" })


return M
