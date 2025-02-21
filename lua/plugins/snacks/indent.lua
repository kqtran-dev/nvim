return {
  "folke/snacks.nvim",
  opts = {
    indent = { 
      enabled = true,
      animate = {
        enabled = vim.fn.has("nvim-0.10") == 1,
        style = "out",
        easing = "linear",
        duration = {
          step = 15, -- ms per step
          total = 250, -- maximum duration
        },
      },
      scope = {
        char = "│"
      }
    },
  }
}
