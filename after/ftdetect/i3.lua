vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*/i3/*.conf", "*/.i3/config", "*/i3/config" },
  callback = function(ev)
    vim.bo[ev.buf].filetype = "i3config"
  end,
})

