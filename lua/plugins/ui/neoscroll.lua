return {
  "karb94/neoscroll.nvim",
  config = function()
    require('neoscroll').setup({
      mappings = {                 -- Keys to be mapped to their corresponding default scrolling animation
        '<C-u>', '<C-d>',
        '<C-f>', '<C-b>',
        '<C-y>', '<C-e>',
        'zt', 'zz', 'zb',
      },
      hide_cursor = true,          -- Hide cursor while scrolling
      stop_eof = true,             -- Stop at <EOF> when scrolling downwards
      respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = false, -- The cursor will keep on scrolling even if the window cannot scroll further
      duration_multiplier = 0.1,    -- Global duration multiplier
      easing = 'quadratic',           -- Default easing function
      pre_hook = nil,              -- Function to run before the scrolling animation starts
      post_hook = nil,             -- Function to run after the scrolling animation ends
      performance_mode = false,    -- Disable "Performance Mode" on all buffers.
      ignored_events = {           -- Events ignored while scrolling
        'WinScrolled', 'CursorMoved'
      },
    })
    local keymap = {
      -- ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 0 }) end;
      -- ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 0 }) end;
      -- ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 0 }) end;
      -- ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 20 }) end;
      -- ["<C-y>"] = function() neoscroll.scroll(-100.1, { move_cursor=false; duration = 1 }) end;
      -- ["<C-e>"] = function() neoscroll.scroll(100.1, { move_cursor=false; duration = 1 }) end;
      -- ["zt"]    = function() neoscroll.zt({ half_win_duration = 1 }) end;
      -- ["zz"]    = function() neoscroll.zz({ half_win_duration = 1 }) end;
      -- ["zb"]    = function() neoscroll.zb({ half_win_duration = 1 }) end;
    }
  end
}

