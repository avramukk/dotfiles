return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim", priority = 1000 },
  enabled = false,
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
    config = function()
      -- Default options:
      require("gruvbox").setup({
        transparent_mode = true,
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
