return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob",
            "!.git",
          },
        },
        extensions = {
          fzf = {},
        },
        pickers = {
          find_files = {
            theme = "ivy",
            find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
          },
          live_grep = {
            -- theme = "ivy",
          },
          buffers = {
            theme = "ivy",
            sort_mru = true,
            ignore_current_buffer = true,
            mappings = {
              i = {
                ["<C-w>"] = "delete_buffer",
              },
              n = {
                ["<C-w>"] = "delete_buffer",
              },
            },
          },
        },
      })
    end,
  },
}
