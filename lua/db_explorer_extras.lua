-- lua/dadbod_explorer_extras.lua
local M = {}

local function detect_mysql(conn)
  conn = (conn or ""):lower()
  return conn:match("^mysql:")
end

local function mysql_show_create_table(tbl)
  return string.format("SHOW CREATE TABLE %s;\n", tbl)
end

local function mysql_select_100(tbl)
  return string.format("SELECT *\nFROM %s\nLIMIT 100;\n", tbl)
end

function M.register()
  local de = require("dadbod-explorer")
  local orig_register = de.register_adapter

  -- Wrap register_adapter so we can extend the built-in mysql adapter without forking the plugin.
  function de.register_adapter(adapter)
    if adapter and adapter.name == "mysql" then
      local old_get_actions = adapter.get_actions
      adapter.get_actions = function(...)
        local actions = old_get_actions and old_get_actions(...) or {}

        actions.select_100 = actions.select_100 or {
          label = "Generate SELECT * LIMIT 100",
          object_list = actions.list_objects and actions.list_objects.object_list or nil,
          process_item = function(_, item)
            local name = tostring(item)
            return { text = mysql_select_100(name) }
          end,
        }

        actions.show_create_table = actions.show_create_table or {
          label = "SHOW CREATE TABLE",
          object_list = actions.list_objects and actions.list_objects.object_list or nil,
          process_item = function(conn, item)
            return { conn = conn, query = mysql_show_create_table(tostring(item)) }
          end,
        }

        return actions
      end
    end

    return orig_register(adapter)
  end

  -- If the mysql adapter is already registered before we wrap, you’ll still be fine:
  -- you can call :Lazy reload / restart nvim once after adding this.
end

return M

