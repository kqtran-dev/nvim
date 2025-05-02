return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  opts = {
    bookmark_0 = {
      sign = "⚑",
      virt_text = "hello world",
      -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
      -- defaults to false.
      annotate = false,
    },
  },
}
