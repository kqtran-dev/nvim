require("core.set")
require("core.remap")
require("core.utils")
require("core.autocmds")
if vim.g.vscode then
  require("core.vscode")
else
  require("core.lazy")
end
