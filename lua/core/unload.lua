-- Disable builtin plugins
local disabled_built_ins = {
   "2html_plugin",
   "bugreport",
   "compiler",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "matchit",
   -- "netrw",
   -- "netrwPlugin",
   -- "netrwSettings",
   -- "netrwFileHandlers",
   "optwin",
   "rrhelper",
   "rplugin",
   "synmenu",
   "spellfile_plugin",
   "tar",
   "tarPlugin",
   "vimball",
   "vimballPlugin",
   "tutor",
   -- "ftplugin",
   "zip",
   "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
   g["loaded_" .. plugin] = 1
end

