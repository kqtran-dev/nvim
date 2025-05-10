require("core.globals")
require("core.unload")
require("core.set")
require("core.remap")
require("core.autocmds")
require("core.lsp")
if vim.g.vscode then
  require("core.vscode")
else
  require("core.lazy")
  -- require("core.utils")
  -- require("core.autocmds")
end
