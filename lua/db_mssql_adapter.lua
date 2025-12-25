-- lua/dadbod_mssql_adapter.lua
local M = {}

local function detect_mssql(conn)
  -- vim-dadbod URLs commonly look like:
  -- sqlserver://user:pass@host:1433?database=DB
  -- mssql://...
  conn = conn or ""
  conn = conn:lower()
  return conn:match("^sqlserver:") or conn:match("^mssql:")
end

local function list_objects_sqlserver()
  return [[
SELECT
  CASE
    WHEN o.type IN ('U') THEN 'table'
    WHEN o.type IN ('V') THEN 'view'
    WHEN o.type IN ('P') THEN 'proc'
    WHEN o.type IN ('FN','IF','TF') THEN 'func'
    ELSE o.type
  END AS kind,
  QUOTENAME(SCHEMA_NAME(o.schema_id)) + '.' + QUOTENAME(o.name) AS name
FROM sys.objects o
WHERE o.is_ms_shipped = 0
  AND o.type IN ('U','V','P','FN','IF','TF')
ORDER BY kind, name;
]]
end

local function describe_sqlserver(qualified_name)
  -- “DDL-ish”: columns for tables/views, plus object definition for views/procs/functions.
  return string.format([[
/* Columns (works for tables/views) */
SELECT
  c.ORDINAL_POSITION,
  c.COLUMN_NAME,
  c.DATA_TYPE,
  c.CHARACTER_MAXIMUM_LENGTH,
  c.NUMERIC_PRECISION,
  c.NUMERIC_SCALE,
  c.IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE (QUOTENAME(c.TABLE_SCHEMA) + '.' + QUOTENAME(c.TABLE_NAME)) = N'%s'
ORDER BY c.ORDINAL_POSITION;

/* Definition (views/procs/functions) */
SELECT OBJECT_DEFINITION(OBJECT_ID(N'%s')) AS [definition];
]], qualified_name, qualified_name)
end

local function select_top_sqlserver(qualified_name)
  return string.format("SELECT TOP (100) *\nFROM %s;\n", qualified_name)
end

local function create_or_alter_view_skeleton_sqlserver(view_name)
  return string.format([[
CREATE OR ALTER VIEW %s
AS
SELECT
  -- columns...
FROM
  -- tables...
;
]], view_name)
end

function M.register()
  local de = require("dadbod-explorer")

  local adapter = {
    name = "sqlserver",
    is_available = function(conn) return detect_mssql(conn) end,
    get_actions = function()
      return {
        list_objects = {
          label = "List objects (tables/views/procs/functions)",
          process_item = function(conn)
            return { conn = conn, query = list_objects_sqlserver() }
          end,
        },

        describe = {
          label = "Describe (columns + definition if available)",
          object_list = function(conn)
            -- object picker list
            local q = list_objects_sqlserver()
            return { conn = conn, query = q }
          end,
          format_item = function(row)
            -- row might be "kind|name" depending on output; keep it simple
            return tostring(row)
          end,
          process_item = function(conn, item)
            -- item should end up as the qualified name; tolerate if it includes kind prefix
            local name = tostring(item):gsub("^%w+%s+", "")
            return { conn = conn, query = describe_sqlserver(name) }
          end,
        },

        select_100 = {
          label = "Generate SELECT TOP (100) *",
          object_list = function(conn) return { conn = conn, query = list_objects_sqlserver() } end,
          process_item = function(_, item)
            local name = tostring(item):gsub("^%w+%s+", "")
            return { text = select_top_sqlserver(name) }
          end,
        },

        create_or_alter_view = {
          label = "Generate CREATE OR ALTER VIEW skeleton",
          process_item = function()
            local view = vim.fn.input("View name (schema.view): ")
            if view == "" then return { text = "" } end
            return { text = create_or_alter_view_skeleton_sqlserver(view) }
          end,
        },
      }
    end,
  }

  de.register_adapter(adapter)
end

return M

