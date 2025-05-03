require("core.unload")
require("core.set")
require("core.remap")
if vim.g.vscode then
  require("core.vscode")
  require("core.autocmds")
else
  require("core.lazy")
  -- require("core.utils")
  require("core.autocmds")
end
