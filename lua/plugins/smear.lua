return {
  "sphamba/smear-cursor.nvim",

  opts = {
    -- Cursor color. Defaults to Normal gui foreground color
    cursor_color = "#d3cdc3",

    -- Background color. Defaults to Normal gui background color
    normal_bg = "#282828",

    -- Smear cursor when switching buffers
    smear_between_buffers = true,

    -- Use floating windows to display smears outside buffers.
    -- May have performance issues with other plugins.
    use_floating_windows = true,

    -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
    -- Smears will blend better on all backgrounds.
    legacy_computing_symbols_support = false,

    -- Attempt to hide the real cursor when smearing.
    hide_target_hack = true,
    stiffness = 0.8,               -- 0.6      [0, 1]
    trailing_stiffness = 0.6,      -- 0.3      [0, 1]
    trailing_exponent = 0,         -- 0.1      >= 0
    distance_stop_animating = 0.5, -- 0.1      > 0
    hide_target_hack = false,      -- true     boolean
  },
}
