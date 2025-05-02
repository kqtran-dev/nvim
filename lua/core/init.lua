require("core.unload")
require("core.set")
require("core.remap")
if vim.g.vscode then
  require("core.vscode")
else
  require("core.lazy")
  require("core.utils")
  require("core.autocmds")
end
