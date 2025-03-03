return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup {
        extensions = {
          fzf = {
          },
        }
      }
    end,
  }
}
