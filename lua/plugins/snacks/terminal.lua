local set = vim.keymap.set
  set("n", "<c-_>", function() Snacks.terminal() end)
  set("t", "<c-_>", function() Snacks.terminal() end)
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"

local function set_default_shell()
  -- if vim.bo.filetype == "python" then
  --   return { "python", "-i" }
  -- end
  if is_windows then
    if vim.fn.executable("pwsh") == 1 then
      return "pwsh"
    else
      return "cmd"
    end
  end
  return vim.o.shell
end

-- Set base shell
local current_shell = set_default_shell()

return {
  "folke/snacks.nvim",
  keys = {
    -- your keybinds
  },
  opts = {
    styles = {
      bo = {
        filetype = "snacks_terminal",
      },
      wo = {},
      keys = {
        q = "hide",
        gf = function(self)
          local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
          if f == "" then
            Snacks.notify.warn("No file under cursor")
          else
            self:hide()
            vim.schedule(function()
              vim.cmd("e " .. f)
            end)
          end
        end,
      },
    },
    terminal = {
      shell = current_shell,
      win = {
        wo = {
          winbar = "",
        },
      },
    },
  },
-- vim.keymap.set("n", "<c-_>", function() Snacks.terminal() end)
-- vim.keymap.set("t", "<c-_>", function() Snacks.terminal() end)
}


